import confirmClick from "confirm-click";

describe("confirmClick", function () {
  const html = [
    '<button data-confirm="Hi!">Hello</button>',
    '<button>Good Bye</button>',
  ].join("");
  let root;

  beforeEach(function () {
    let template = document.createElement("template");
    template.innerHTML = `<div>${html}</div>`;
    root = template.content.firstChild;
    spyOn(window, "confirm");
    confirmClick(root);
  });

  describe("for an element without the data attribute", function () {
    let element;

    beforeEach(function () {
      element = root.children[1];
      expect(element.dataset.confirm).not.toBeDefined();
    });

    describe("clicking", function () {
      beforeEach(function () {
        element.click();
      });

      it("does not trigger a confirmation dialog", function () {
        expect(window.confirm).not.toHaveBeenCalled();
      });
    });
  });

  describe("for an element with the data attribute", function () {
    let element;

    beforeEach(function () {
      element = root.children[0];
      expect(element.dataset.confirm).toBeDefined();
    });

    describe("clicking", function () {
      beforeEach(function () {
        element.click();
      });

      it("triggers a confirmation dialog", function () {
        expect(window.confirm).toHaveBeenCalledWith("Hi!");
      });
    });
  });
});
