module Users
  class RegistrationsController < Devise::RegistrationsController
    after_action :sync_products

    private

    def sync_products
      return if resource.token.blank?

      SyncProductsJob.perform_later(resource.id)
    end
  end
end
