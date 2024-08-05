import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slide", "indicator"]

  connect() {
    this.currentIndex = 0
    this.showCurrentSlide()
    this.startCarousel()

    // Add event listeners for hover
    this.element.addEventListener('mouseenter', this.stopCarousel.bind(this))
    this.element.addEventListener('mouseleave', this.startCarousel.bind(this))
  }

  startCarousel() {
    if (!this.interval) {
      this.interval = setInterval(() => {
        this.nextSlide()
      }, 3000) // Change image every 3 seconds
    }
  }

  stopCarousel() {
    clearInterval(this.interval)
    this.interval = null
  }

  showCurrentSlide() {
    this.slideTargets.forEach((slide, index) => {
      slide.classList.toggle("block", index === this.currentIndex)
      slide.classList.toggle("hidden", index !== this.currentIndex)
      slide.classList.toggle("opacity-100", index === this.currentIndex)
      slide.classList.toggle("opacity-0", index !== this.currentIndex)
    })
    this.updateIndicators()
  }

  nextSlide() {
    this.currentIndex = (this.currentIndex + 1) % this.slideTargets.length
    this.showCurrentSlide()
  }

  prevSlide() {
    this.currentIndex = (this.currentIndex - 1 + this.slideTargets.length) % this.slideTargets.length
    this.showCurrentSlide()
  }

  goToSlide(event) {
    this.currentIndex = parseInt(event.currentTarget.dataset.carouselSlideTo)
    this.showCurrentSlide()
  }

  updateIndicators() {
    this.indicatorTargets.forEach((indicator, index) => {
      indicator.classList.toggle("bg-white", index === this.currentIndex)
      indicator.classList.toggle("bg-gray-300", index !== this.currentIndex)
    })
  }

  disconnect() {
    clearInterval(this.interval)
  }
}
