// Find every element with a `data-active` attribute. If the attribute is equal
// to the current path of the URL, set an `active` class on it.
export default function markActive(nodes, pathname) {
  nodes.querySelectorAll("[data-active]").forEach(function (element) {
    let paths = element.dataset.active.split(",")
    let patterns = paths.map(function (path) { return path + ".*" })
    let pattern = new RegExp(patterns.join("|"))
    if (pattern.test(pathname)) {
      element.classList.add("active")
    }
  })
}
