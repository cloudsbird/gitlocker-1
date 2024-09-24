require 'zip'
require 'json'

module ProductConcern
  extend ActiveSupport::Concern

  def fetch_product_directory_tree(product)
    if product.directory_tree.present? 
      directory_tree = begin 
        eval(product.directory_tree) 
      rescue 
        []
      end
    else
      directory_tree = []
    end
    directory_tree.to_json.html_safe
  end

  def zip_structure_for_js_tree(file_path)
    structure = {}
    Zip::File.open(file_path) do |zip_file|
      sorted_entries = zip_file.sort_by { |entry| [entry.directory? ? 0 : 1, entry.name] }
      sorted_entries.each do |entry|
        parts = entry.name.split('/')
        current_level = structure
        parts.each_with_index do |part, index|
          if index == parts.size - 1
            if entry.directory?
              current_level[part] ||= {}
            else
              current_level[part] = 'file'
            end
          else
            current_level[part] ||= {}
            current_level = current_level[part]
          end
        end
      end
    end
    convert_to_js_tree_format(structure)
  end
  
  def convert_to_js_tree_format(structure)
    structure.map do |key, value|
      if value.is_a?(Hash)
        { text: key, children: convert_to_js_tree_format(value) }
      else
        { text: key, icon: 'jstree-file' }
      end
    end
  end
end