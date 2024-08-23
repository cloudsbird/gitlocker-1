document.addEventListener('turbolinks:load', () => {
  const categoryFilterForm = document.getElementById('category_filter_form');
  if (categoryFilterForm) {
    categoryFilterForm.addEventListener('submit', function (event) {
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
          const newContent = doc.getElementById('categories_list').innerHTML;
          document.getElementById('categories_list').innerHTML = newContent;
        })
        .catch(error => console.error('Error:', error));
    });
  }
});
