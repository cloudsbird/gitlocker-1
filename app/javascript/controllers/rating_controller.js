import { Controller } from "@hotwired/stimulus"

const starColors = {
  'yellow': 'fill-amber-400',
  'gray': 'fill-gray-300'
};

// Connects to data-controller="rating"
export default class extends Controller {
  static targets = ['star'];

  connect() {
    console.log('rating');
  }

  highlight(e) {
    const rating = parseInt(e.target.dataset.rating);

    if (isNaN(rating)) return;

    this.starTargets.forEach((star) => {
      star.classList.remove(starColors['gray']);
      star.classList.add(starColors['yellow']);

      if (parseInt(star.dataset.rating) <= rating) {
        star.classList.remove(starColors['gray']);
        star.classList.add(starColors['yellow']);
      } else {
        star.classList.remove(starColors['yellow']);
        star.classList.add(starColors['gray']);
      }
    });
  }
}
