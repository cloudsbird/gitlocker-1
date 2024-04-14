class SearchResultsController < ApplicationController
  def index
    results = PgSearch.multisearch(params[:search])
    @products = results.map(&:searchable)
  end
end
