document.addEventListener('turbolinks:load', () => {
  const productFilterForm = document.getElementById('product_filter_form');
  if (productFilterForm) {
    productFilterForm.addEventListener('submit', function (event) {
      event.preventDefault();
      const formData = new FormData(this);
      const params = new URLSearchParams(formData).toString();

      fetch(`${this.action}?${params}`, {
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
      })
        .then(response => response.text())
        .then(html => {
          const parser = new DOMParser();
          const doc = parser.parseFromString(html, 'text/html');
          const newContent = doc.getElementById('product_list').innerHTML;
          document.getElementById('product_list').innerHTML = newContent;
        })
        .catch(error => console.error('Error:', error));
    });
  }
});
