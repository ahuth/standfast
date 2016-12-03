import markActive from "mark-active";

describe("markActive", function () {
  const html = [
    '<li data-active="/foobar,/batbaz">First</li>',
    '<li data-active="/fizzbuzz">Second</li>'
  ].join("");
  let root;

  beforeEach(function () {
    let template = document.createElement("template");
    template.innerHTML = `<div>${html}</div>`;
    root = template.content.firstChild;
  });

  it("runs successfully", function () {
    expect(() => {
      markActive(root);
    }).not.toThrow();
  });
});
