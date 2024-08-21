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
    this.logCarouselMovement(1)
    this.currentIndex = (this.currentIndex + 1) % this.slideTargets.length
    this.showCurrentSlide()
  }

  prevSlide() {
    this.logCarouselMovement(-1)
    this.currentIndex = (this.currentIndex - 1 + this.slideTargets.length) % this.slideTargets.length
    this.showCurrentSlide()
  }

  goToSlide(event) {
    const newIndex = parseInt(event.currentTarget.dataset.carouselSlideTo)
    const direction = newIndex > this.currentIndex ? 1 : -1
    this.logCarouselMovement(direction, newIndex)
    this.currentIndex = newIndex
    this.showCurrentSlide()
  }

  logCarouselMovement(direction, newIndex = null) {
    const currentIndex = this.currentIndex
    const targetIndex = newIndex !== null ? newIndex : (currentIndex + direction) % this.slideTargets.length
    const marketplaceID = this.slideTargets[currentIndex].querySelector('.marketplace-id').textContent

    console.log(`Current index: ${currentIndex + 1}, Direction: ${direction}`)
    console.log(`${marketplaceID} New index: ${targetIndex + 1}`)
    console.log(`${this.slideTargets[targetIndex].querySelector('.marketplace-id').textContent} Scrolling to index: ${targetIndex + 1}`)
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
