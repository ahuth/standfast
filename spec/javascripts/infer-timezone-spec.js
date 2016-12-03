import inferTimezone from "infer-timezone";

describe("inferTimezone", function () {
  const html = [
    '<a class="link1" data-infer-timezone="true" href="/test">link1</a>',
    '<a class="link2" data-infer-timezone="false" href="/test">link2</a>',
    '<a class="link3" href="/test">link3</a>'
  ].join("");
  let root;

  beforeEach(function () {
    let template = document.createElement("template");
    template.innerHTML = `<div>${html}</div>`;
    root = template.content.firstChild;
  });

  it("adds the rails time zone to link paths with infer-timezone=true", function () {
    inferTimezone(root);
    expect(root.children[0].getAttribute("href")).not.toEqual("/test");
    expect(root.children[1].getAttribute("href")).toEqual("/test");
    expect(root.children[2].getAttribute("href")).toEqual("/test");
  });
});
