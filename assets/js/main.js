(function() {
  updateYear();
})();

function updateYear() {
  const footerClass = '.site-footer__date';

  const footerElement = document.querySelector(footerClass);

  const date = new Date(Date.now());

  footerElement.textContent = date.getFullYear();
};

