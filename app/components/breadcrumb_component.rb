# frozen_string_literal: true

class BreadcrumbComponent < ViewComponent::Base
  def initialize(links)
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
