# frozen_string_literal: true

class SearchDialogComponent < ViewComponent::Base
  def initialize(search_path:)
    @search_path = search_path
  end
end
