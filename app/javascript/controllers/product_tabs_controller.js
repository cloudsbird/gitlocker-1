import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="product-tabs"
export default class extends Controller {
  static targets = ['button'];
  connect() {
    console.log('hello world product tabs');
  }

  toggleTab(e) {
    const tabName = e.target.id.replace('tab-', '');
    console.log('inside toggleTab: ', tabName);

    document.getElementById(`tab-panel-${tabName}`);
  }
}
