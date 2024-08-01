module Marketplace
  class SearchResultsController < ApplicationController
    def index
      if params[:search].present?
        @product_results = Product.search(params[:search])
        @marketplace_creator_results = User.search(params[:search])
        @category_results = Category.search(params[:search])
        @language_results = Language.search(params[:search])

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
  end
end
