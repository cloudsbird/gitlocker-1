# app/components/popular_product_carousel_component.rb
class PopularProductCarouselComponent < ViewComponent::Base
  def initialize(popular_products)
    @popular_products = popular_products
  end

  def paginated_products(page: 1, per_page: 5)
    @popular_products.each_slice(per_page).to_a[page - 1] || []
  end

  def total_pages(per_page: 5)
    (@popular_products.size / per_page.to_f).ceil
  end
end
