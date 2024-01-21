module Users
  class RegistrationsController < Devise::RegistrationsController
    after_action :sync_products

    private

    def sync_products
      SyncProductsJob.perform_later(resource.id)
    end
  end
end
