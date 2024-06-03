ActiveAdmin.register Refund do
  permit_params :description, :product_id, :stripe_transaction_screenshot, :status

  filter :product
  filter :description
  filter :status, as: :select, collection: -> { Refund.pluck(:status).uniq }

  index do
    selectable_column
    id_column
    column :product
    column :description
    column :status do |refund|
      if refund.status == 'pending'
        links = link_to('Approve', approve_admin_refund_path(refund), method: :put, class: 'member_link') +
                ' / ' +
                link_to('Deny', deny_admin_refund_path(refund), method: :put, class: 'member_link')
        links.html_safe
      else
        refund.status.capitalize
      end
    end
    actions
  end

  member_action :approve, method: :put do
    resource.approve!
    redirect_to resource_path, notice: "Refund ##{resource.id} approved and marked as completed."
  end

  member_action :deny, method: :put do
    resource.deny!
    redirect_to resource_path, notice: "Refund ##{resource.id} denied."
  end
end
