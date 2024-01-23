import { Controller } from "@hotwired/stimulus";
import { get } from '@rails/request.js';

// Connects to data-controller="github-sync"
export default class extends Controller {
  static targets = ['loader', 'container'];

  connect() {
    this.checkSync();
  }

  async renderProducts() {
    const response = await get(this.element.dataset.productApiUrl, { responseKind: 'turbo-stream' });

    if (response.ok) {
      const responseBody = await response.text;
      Turbo.renderStreamMessage(responseBody);
      this.loaderTarget.classList.add('hidden');
      this.containerTarget.classList.remove('opacity-20');
    }
  }

  async checkSync() {
    const response = await get(this.element.dataset.syncApiUrl, { responseKind: 'json' });

    if (response.ok) {
      const responseBody = await response.json;
      const userAttributes = responseBody.data.attributes;

      if (userAttributes.synced && !userAttributes.syncing) {
        this.renderProducts();
      }
    }
  }
}
