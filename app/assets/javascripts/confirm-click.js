// @flow

// For every element with a `data-confirm` attribute, show a confirmation dialog
// after clicking. The value of the `data-confirm` attribute will be shown in
// the dialog, and canceling should prevent the action from taking place.
export default function confirmClick(nodes: Document) {
  Array.from(nodes.querySelectorAll("[data-confirm]")).forEach(function (element: HTMLElement) {
    element.onclick = function (event: Object) {
      return window.confirm(event.target.dataset.confirm)
    }
  })
}
