import { Controller } from '@hotwired/stimulus';
import { toggle } from 'el-transition';
import { useHover } from 'stimulus-use';

export default class extends Controller {
  static targets = ['menu', 'menuItem'];

  connect() {
    this.menuItemTargets.forEach((menuItem) => {
      useHover(this, { element: menuItem });
    });

    document.addEventListener('click', this.handleClickOutside.bind(this));
  }

  disconnect() {
    document.removeEventListener('click', this.handleClickOutside.bind(this));
  }

  handleClickOutside(event) {
    if (!this.element.contains(event.target)) {
      if (this.menuTarget.classList.contains('hidden')) {
        return;
      }
      toggle(this.menuTarget);
    }
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
