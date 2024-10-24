import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="search-dialog"
export default class extends Controller {
  static targets = ['container'];

  connect() {
    document.body.addEventListener('click', (e) => {
      if (e.target.classList.contains('search-link')) {
        return;
      }

      if (!this.containerTarget.contains(e.target)) {
        this.element.classList.add('hidden');
      }
    });
  }

  submit(e) {
    if (e.key === 'Enter' || e.keyCode === 13) {
      window.location.href = `/marketplace/search?search=${e.target.value}`;
    }
  }
}
