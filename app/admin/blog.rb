ActiveAdmin.register Blog do
  permit_params :title, :content, :image, :slug

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  index do
    selectable_column
    id_column
    column :title
    column :slug
    column :created_at
    actions
  end

  filter :title
  filter :slug
  filter :content
  filter :created_at

  form do |f|
    f.inputs do
      f.input :title
      f.input :content, as: :quill_editor
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :slug
      row :content do |blog|
        blog.content.html_safe
      end
      row :image do |blog|
        if blog.image.attached?
          image_tag url_for(blog.image)
        end
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
