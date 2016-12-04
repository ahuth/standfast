import inferTimezone from "infer-timezone"
import {parseDom} from "../support/javascripts"

describe("inferTimezone", function () {
  const html = [
    '<a class="link1" data-infer-timezone="true" href="/test">link1</a>',
    '<a class="link2" data-infer-timezone="false" href="/test">link2</a>',
    '<a class="link3" href="/test">link3</a>'
  ].join("")
  let root

  beforeEach(function () {
    root = parseDom(html)
  })

  describe("with a known timezone", function () {
    const timezone = "Asia/Kolkata"

    it("adds the rails time zone to link paths with infer-timezone=true", function () {
      inferTimezone(root, timezone)
      expect(root.children[0].getAttribute("href")).toEqual("/test?time_zone=Mumbai")
      expect(root.children[1].getAttribute("href")).toEqual("/test")
      expect(root.children[2].getAttribute("href")).toEqual("/test")
    })
  })

  describe("with an unknown timezone", function () {
    const timezone = "Mars"

    it("does not add anything to the links", function () {
      inferTimezone(root, timezone)
      expect(root.children[0].getAttribute("href")).toEqual("/test")
      expect(root.children[1].getAttribute("href")).toEqual("/test")
      expect(root.children[2].getAttribute("href")).toEqual("/test")
    })
  })
})
