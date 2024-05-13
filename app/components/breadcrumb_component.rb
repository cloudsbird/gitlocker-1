# frozen_string_literal: true

class BreadcrumbComponent < ViewComponent::Base
  def initialize(current_user, links)
    @current_user = current_user
    @links = structify(links)
  end

  private

  Link = Struct.new(:text, :url)

  def structify(links)
    links.map do |link|
      Link.new(link[:text], link[:url])
    end
  end
end
