import { Controller } from '@hotwired/stimulus';
import { get } from '@rails/request.js';

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

  async submit(e) {
    if (e.key === 'Enter' || e.keyCode === 13) {
      const response = await get(e.target.dataset.searchUrl, {
        query: {
          search: e.target.value
        },
        responseKind: 'html'
      });

      if (response.ok) {
        response.redirected
      }
    }
  }
}
