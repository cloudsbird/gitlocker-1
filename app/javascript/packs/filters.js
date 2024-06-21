// app/javascript/packs/filters.js
document.addEventListener('turbolinks:load', () => {
  const filterForm = document.getElementById('filter_form');
  if (filterForm) {
    filterForm.addEventListener('submit', function (event) {
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
          const newContent = doc.getElementById('products_list').innerHTML;
          document.getElementById('products_list').innerHTML = newContent;
        })
        .catch(error => console.error('Error:', error));
    });
  }
});
