import { Controller } from '@hotwired/stimulus';
import { DirectUpload } from "@rails/activestorage"

const imageTypes = ['image/gif', 'image/jpeg', 'image/png'];

// Connects to data-controller="product-form"
export default class extends Controller {
  static targets = ['coverInput'];

  attachCover(e) {
    e.preventDefault();

    const file = e.target.files[0];

    if (!imageTypes.includes(file.type)) {
      alert('Attached file must be an image');
    }

    const image = new Image();
    const imageObject = URL.createObjectURL(file);

    image.addEventListener('load', () => {
      if (image.width < 1280 || image.height < 720) {
        alert('Cover Image must be at least 1280x720px');
        return;
      }

      console.log('coverInputTarget.files: ', this.coverInputTarget.files);
      this.coverInputTarget.files.push(e.target.files);
      this.coverTarget.src = imageObject;
    });

    image.src = imageObject;
  }
}
