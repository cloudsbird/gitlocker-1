import { Controller } from '@hotwired/stimulus';
import { toggle } from 'el-transition';

// Connects to data-controller="product-card"
export default class extends Controller {
  static targets = ['menu'];

  open() {
    toggle(this.menuTarget);
  }
}
