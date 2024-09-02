ActiveAdmin.register Payment do
  index do
    selectable_column
    id_column
    column :user_email
    column :total_currency
    column :total_cents
    column :stripe_charge_id
    column :created_at
    actions defaults: false do |payment|
      link_to 'View', admin_payment_path(payment)
    end 
  end

  filter :stripe_charge_id
  filter :user_email

  show do
    attributes_table do
      row :user_email
      row :total_currency
      row :total_cents
      row :stripe_charge_id
      row :created_at
      row :line_items do |payment|
        ul do
          payment.purchases.each do |purchase|
            li do
              purchase.product.name
            end
          end
        end
      end
    end
    active_admin_comments
  end
end
