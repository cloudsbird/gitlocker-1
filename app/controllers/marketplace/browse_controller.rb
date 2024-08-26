module Marketplace
  class BrowseController < ApplicationController
    def index
      @products = apply_filters_and_sort(Product.exclude_purchased(current_user))
    end

    def popular
      @products = apply_filters_and_sort(Product.exclude_purchased(current_user).order(purchases_count: :desc))
    end

    def recent
      @products = apply_filters_and_sort(Product.exclude_purchased(current_user))

      respond_to do |format|
        format.html
        format.js
      end
    end

    def languages
      @languages = sort_categories(Language.page(params[:page]).per(50), params[:sort_by])
    end

    def categories
      @categories = sort_categories(Category.page(params[:page]).per(50), params[:sort_by])
    end

    private

    def filter_params
      params.permit(:category, :language, :sort_by)
    end

    def apply_filters_and_sort(resource)
      # Apply filtering if needed (e.g., by category or language)
      resource = resource.where(category_id: filter_params[:category]) if filter_params[:category].present?
      resource = resource.where(language_id: filter_params[:language]) if filter_params[:language].present?

      # Apply sorting based on criteria
      case filter_params[:sort_by]
      when 'alphabetical_asc'
        resource.order(name: :asc)
      when 'alphabetical_desc'
        resource.order(name: :desc)
      when 'oldest'
        resource.order(created_at: :asc)
      else
        resource.order(name: :asc) # Default sorting
      end.page(params[:page]).per(50)
    end

    def sort_categories(categories, criteria)
      case criteria
      when 'alphabetical_asc'
        categories.order(name: :asc)
      when 'alphabetical_desc'
        categories.order(name: :desc)
      when 'oldest'
        categories.order(created_at: :asc)
      else
        categories.order(name: :asc) # Default sorting
      end
    end
  end
end
