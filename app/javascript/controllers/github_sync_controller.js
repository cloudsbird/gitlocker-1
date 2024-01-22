import { Controller } from "@hotwired/stimulus";
import { get } from '@rails/request.js';

// Connects to data-controller="github-sync"
export default class extends Controller {
  connect() {
    console.log('apiUrl: ', this.element.dataset.apiUrl);
    this.checkSync();
  }

  async renderProducts() {
    console.log('inside renderAllProducts');
  }

  async checkSync() {
    const response = await get(this.element.dataset.apiUrl, { responseKind: 'json' });

    if (response.ok) {
      const responseBody = await response.json
      const userAttributes = responseBody.data.attributes;

      if (userAttributes.synced && !userAttributes.syncing) {
        this.renderProducts();
      }
    }
  }
}
