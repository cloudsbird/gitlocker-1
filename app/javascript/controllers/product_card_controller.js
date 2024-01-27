import { Controller } from '@hotwired/stimulus';
import { toggle } from 'el-transition';
import { useHover } from 'stimulus-use';

// Connects to data-controller="product-card"
export default class extends Controller {
  static targets = ['menu', 'menuItem'];

  connect() {
    this.menuItemTargets.forEach((menuItem) => {
      useHover(this, { element: menuItem });
    });
  }

  open() {
    toggle(this.menuTarget);
  }

  mouseEnter(e) {
    e.target.classList.add('bg-gray-50');
  }

  mouseLeave(e) {
    e.target.classList.remove('bg-gray-50');
  }
}
