ActiveAdmin.register Blog do
  permit_params :title, :content, :image

  index do
    selectable_column
    id_column
    column :title
    column :content
    column :created_at
    actions
  end

  filter :title
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
