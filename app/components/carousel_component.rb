# frozen_string_literal: true

class CarouselComponent < ViewComponent::Base
  def initialize(images, carousel_class = "object-cover object-center relative w-full")
    @images = images
    @carousel_class = carousel_class
  end
end
