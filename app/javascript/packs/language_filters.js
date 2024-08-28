document.addEventListener('turbolinks:load', () => {
  const languageFilterForm = document.getElementById('language_filter_form');
  if (languageFilterForm) {
    languageFilterForm.addEventListener('submit', function (event) {
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
          const newContent = doc.getElementById('languages_list').innerHTML;
          document.getElementById('languages_list').innerHTML = newContent;
        })
        .catch(error => console.error('Error:', error));
    });
  }
});
