# app/components/product_carousel_component.rb
class ProductCarouselComponent < ViewComponent::Base
  def initialize(recent_products)
    @recent_products=recent_products
  end

  def paginated_products(page: 1, per_page: 5)
    @recent_products.each_slice(per_page).to_a[page - 1] || []
  end

  def total_pages(per_page: 5)
    (@recent_products.size / per_page.to_f).ceil
  end
end
