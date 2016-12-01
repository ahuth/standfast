// For every element with a `data-confirm` attribute, show a confirmation dialog
// after clicking. The value of the `data-confirm` attribute will be shown in
// the dialog, and canceling should prevent the action from taking place.
document.addEventListener("turbolinks:load", function (event) {
  let elements = document.querySelectorAll("[data-confirm]");
  elements.forEach(function (element) {
    element.onclick = function (event) {
      return window.confirm(event.target.dataset.confirm);
    };
  });
});
