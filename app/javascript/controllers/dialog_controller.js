import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dialog"
export default class extends Controller {
  static targets = ['container'];

  connect() {
    document.body.addEventListener('click', (e) => {
      if (!this.containerTarget.contains(e.target)) {
        this.element.classList.add('hidden');
      }
    });
  }
}
