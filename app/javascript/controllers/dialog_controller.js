import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dialog"
export default class extends Controller {
  static targets = ['container'];

  connect() {
    if (this.element.dataset.disabled === 'true') {
      return;
    }

    document.body.addEventListener('click', (e) => {
      if (!this.containerTarget.contains(e.target)) {
        this.element.classList.add('hidden');
        this.stopAllVideos();
      }
    });
  }

  stopAllVideos() {
    this.containerTarget.querySelectorAll('iframe').forEach(v => { v.src = v.src });
    this.containerTarget.querySelectorAll('video').forEach(v => { v.pause() });
  }
}
