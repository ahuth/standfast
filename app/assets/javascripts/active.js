// Find every element with a `data-active` attribute. If the attribute is equal
// to the current path of the URL, set an `active` class on it.
document.addEventListener("turbolinks:load", function (event) {
  var elements = document.querySelectorAll("[data-active]");
  var path = window.location.pathname;
  elements.forEach(function (element) {
    var pattern = new RegExp(element.dataset.active + ".*");
    if (pattern.test(path)) {
      element.classList.add("active")
    }
  });
});
