// Take an HTML string and convert it into real DOM nodes.
export default function parseDom(html) {
  let template = document.createElement("template");
  template.innerHTML = `<div>${html}</div>`;
  return template.content.firstChild;
}
