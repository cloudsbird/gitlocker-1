module Marketplace
class BrowseController < ApplicationController
  def index
    @products = Product.exclude_purchased(current_user).filter_and_sort(filter_params).page(params[:page]).per(50)
  end

  def popular
    @products = Product.exclude_purchased(current_user).order(purchases_count: :desc).filter_and_sort(filter_params).page(params[:page]).per(50)
  end

  def recent
    @products = Product.exclude_purchased(current_user)
                       .filter_and_sort(filter_params)
                       .page(params[:page]).per(50)

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
