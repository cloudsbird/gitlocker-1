// app/javascript/controllers/product_carousel_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["pages"]

  connect() {
    this.currentPage = 0
    this.totalPages = this.pagesTargets.length
  }

  nextPage() {
    this.currentPage = (this.currentPage + 1) % this.totalPages
    this.showPage(this.currentPage)
  }

  prevPage() {
    this.currentPage = (this.currentPage - 1 + this.totalPages) % this.totalPages
    this.showPage(this.currentPage)
  }

  showPage(pageIndex) {
    this.pagesTargets.forEach((page, index) => {
      page.classList.toggle("active", index === pageIndex)
    })
  }
}
