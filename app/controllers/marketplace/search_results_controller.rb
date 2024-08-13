module Marketplace
  class SearchResultsController < ApplicationController
    def index
      if params[:search].present?
        @product =  sort_products(Product.all, params[:sort_by])
        @product_results = @product.search(params[:search]).page(params[:page]).per(5)
        @marketplace_creator_results = User.search(params[:search]).page(params[:page]).per(5)
        @category_results = Category.search(params[:search]).page(params[:page]).per(5)
        @language_results = Language.search(params[:search]).page(params[:page]).per(5)

        if params[:category_id].present?
          @product_results = @product_results.joins(:product_categories)
                                             .where(product_categories: { category_id: params[:category_id] })
        end
      else
        @product_results = []
        @marketplace_creator_results = []
        @category_results = []
        @language_results = []
      end
    end

    def filter_params
      params.permit(:sort_by)
    end

    def sort_products(products, criteria)
      case criteria
      when 'alphabetical_asc'
        products.order(name: :asc)
      when 'alphabetical_desc'
        products.order(name: :desc)
      when 'cheapest'
        products.order(price_cents: :asc)
      when 'most_expensive'
        products.order(price_cents: :desc)
      when 'most_likes'
        products.left_joins(:likes)
                .group('products.id')
                .order('COUNT(likes.id) DESC NULLS LAST')
      when 'most_recent'
        products.order(created_at: :desc)
      when 'oldest'
        products.order(created_at: :asc)
      else
        products.order(created_at: :desc) 
      end
    end
  end
end
