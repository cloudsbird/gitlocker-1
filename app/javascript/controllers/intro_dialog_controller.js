import { Controller } from '@hotwired/stimulus';
import { post } from '@rails/request.js';

// Connects to data-controller="intro-dialog"
export default class extends Controller {
  static targets = ['emailForm', 'emailInput', 'subscribed'];

  async subscribeToEmail(e) {
    e.preventDefault();

    if (this.emailInputTarget.value.length === 0) {
      alert('Please fill in the email address');
      return;
    }

    const response = await post(this.element.dataset.apiUrl, {
      body: { email: this.emailInputTarget.value },
      responseKind: 'application/json'
    });

    if (response.ok) {
      this.emailFormTarget.classList.add('hidden');
      this.subscribedTarget.classList.remove('hidden');
    }
  }
}
