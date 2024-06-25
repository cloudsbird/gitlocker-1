import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="search-link"
export default class extends Controller {
  openDialog(e) {
    debugger
    e.preventDefault();

    document.getElementById(this.element.dataset.searchDialogId).classList.remove('hidden');
  }
}
