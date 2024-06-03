class SearchResultsController < ApplicationController
  def index
    if params[:search].present?
      # results = PgSearch.multisearch(params[:search])
      # @products = results.map(&:searchable)
      @product_results = Product.search(params[:search])
      @marketplace_creator_results = User.search(params[:search])
      # @category_results = Category.search(params[:search])
      # @language_results = Language.search(params[:search])
    else
      @products = []
    end
  end
end
