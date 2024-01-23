import { Controller } from "@hotwired/stimulus";
import { get } from '@rails/request.js';

// Connects to data-controller="github-sync"
export default class extends Controller {
  connect() {
    console.log('syncApiUrl: ', this.element.dataset.syncApiUrl);
    console.log('productApiUrl: ', this.element.dataset.productApiUrl);
    this.checkSync();
  }

  async renderProducts() {
    console.log('inside renderAllProducts');
    const response = await get(this.element.dataset.productApiUrl, { responseKind: 'json' });

    if (response.ok) {
      const responseBody = await response.json
      console.log('products responseBody: ', responseBody);
    }
  }

  async checkSync() {
    const response = await get(this.element.dataset.syncApiUrl, { responseKind: 'json' });

    if (response.ok) {
      const responseBody = await response.json
      const userAttributes = responseBody.data.attributes;

      if (userAttributes.synced && !userAttributes.syncing) {
        this.renderProducts();
      }
    }
  }
}
