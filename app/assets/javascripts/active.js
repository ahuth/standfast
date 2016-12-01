// Find every element with a `data-active` attribute. If the attribute is equal
// to the current path of the URL, set an `active` class on it.
document.addEventListener("turbolinks:load", function (event) {
  let elements = document.querySelectorAll("[data-active]");
  let path = window.location.pathname;
  elements.forEach(function (element) {
    let paths = element.dataset.active.split(",");
    let patterns = paths.map(function (path) { return path + ".*"; });
    let pattern = new RegExp(patterns.join("|"));
    if (pattern.test(path)) {
      element.classList.add("active");
    }
  });
});
