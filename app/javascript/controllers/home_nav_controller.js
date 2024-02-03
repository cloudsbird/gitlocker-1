import { Controller } from '@hotwired/stimulus';
import { enter, leave } from 'el-transition';

// Connects to data-controller="home-nav"
export default class extends Controller {
  static targets = ['mobileMenu'];

  close() {
    leave(this.mobileMenuTarget);
  }

  open() {
    enter(this.mobileMenuTarget);
  }
}
