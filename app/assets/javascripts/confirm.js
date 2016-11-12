document.addEventListener("turbolinks:load", function (event) {
  const elements = document.querySelectorAll("[data-confirm]")
  elements.forEach(function (element) {
    element.onclick = function (event) {
      return window.confirm(event.target.dataset.confirm);
    };
  });
});
