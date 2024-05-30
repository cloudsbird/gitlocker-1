ActiveAdmin.register Refund do
  permit_params :description, :product_id, :stripe_transaction_screenshot

  filter :product
  filter :description

  index do
    selectable_column
    id_column
    column :product
    column :description
    actions
  end
end
