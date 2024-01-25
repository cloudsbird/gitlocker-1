import { Controller } from "@hotwired/stimulus";
import { get, put } from '@rails/request.js';

// Connects to data-controller="github-sync"
export default class extends Controller {
  static targets = ['loader', 'container', 'divider', 'button'];

  connect() {
    this.checkSync();
  }

  submit() {
    const products = document.querySelectorAll('[name="product_ids[]"]');
    const checkedProducts = Array.from(products).filter((product) => {
      return product.checked;
    });
    const checkedProductIds = checkedProducts.map((product) => {
      return parseInt(product.value);
    });

    if (checkedProductIds.length === 0) {
      alert('Please select repositories to import');
      return;
    }

    this.submitProducts(checkedProductIds);
  }

  async submitProducts(productIds) {
    const response = await put(this.element.dataset.productActivationsApiUrl, {
      body: { product_ids: productIds },
      responseKind: 'json'
    });

    if (response.ok) {
      window.location.href = '/dashboard';
    }
  }

  async renderProducts() {
    const response = await get(this.element.dataset.productApiUrl, { responseKind: 'turbo-stream' });

    if (response.ok) {
      const responseBody = await response.text;
      this.loaderTarget.classList.add('hidden');
      this.containerTarget.classList.remove('opacity-20');
      this.dividerTarget.classList.remove('hidden');
      this.buttonTarget.classList.remove('hidden');
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
