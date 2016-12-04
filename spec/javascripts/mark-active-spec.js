import markActive from "mark-active"
import {parseDom} from "../support/javascripts"

describe("markActive", function () {
  const html = [
    '<li data-active="/foobar,/batbaz">First</li>',
    '<li data-active="/fizzbuzz">Second</li>',
  ].join("")
  let root

  beforeEach(function () {
    root = parseDom(html)
  })

  describe("when the pathname does not match any of the attributes", function () {
    const pathname = "/what"

    it("does not add any classes", function () {
      markActive(root, pathname)
      expect(root.children[0].classList.contains("active")).toEqual(false)
      expect(root.children[1].classList.contains("active")).toEqual(false)
    })
  })

  describe("when the pathname matches an element with a single attribute value", function () {
    const pathname = "/fizzbuzz"

    it("adds a class to matching elements", function () {
      markActive(root, pathname)
      expect(root.children[1].classList.contains("active")).toEqual(true)
    })

    it("does not add a class to non-matching elements", function () {
      markActive(root, pathname)
      expect(root.children[0].classList.contains("active")).toEqual(false)
    })
  })

  describe("when the pathname matches an element with multiple attribute values", function () {
    const pathname = "/batbaz"

    it("adds a class to matching elements", function () {
      markActive(root, pathname)
      expect(root.children[0].classList.contains("active")).toEqual(true)
    })

    it("does not add a class to non-matching elements", function () {
      markActive(root, pathname)
      expect(root.children[1].classList.contains("active")).toEqual(false)
    })
  })
})
