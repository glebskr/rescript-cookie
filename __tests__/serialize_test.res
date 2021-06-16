open Jest
open Expect
open Cookie

describe("Basic", () => {
  test("foo=bar", () => {
    expect(serialize(~name="foo", ~value="bar", ())) |> toEqual("foo=bar")
  })
  test("foo=123", () => {
    expect(serialize(~name="foo", ~value="123", ())) |> toEqual("foo=123")
  })
})

describe("With options", () => {
  test("path ", () => {
    expect(serialize(~name="foo", ~value="bar", ~path=Some("/"), ())) |> toEqual("foo=bar; Path=/")
  })
  test("secure", () => {
    expect(serialize(~name="foo", ~value="bar", ~secure=Some(true), ())) |> toEqual(
      "foo=bar; Secure",
    )
  })
  test("domain ", () => {
    expect(serialize(~name="foo", ~value="bar", ~domain=Some("example.com"), ())) |> toEqual(
      "foo=bar; Domain=example.com",
    )
  })
  test("sameSite ", () => {
    expect(serialize(~name="foo", ~value="bar", ~sameSite=Some("Strict"), ())) |> toEqual(
      "foo=bar; SameSite=Strict",
    )
  })
})
