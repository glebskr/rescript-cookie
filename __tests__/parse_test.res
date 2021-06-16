open Jest
open Expect
open Cookie

describe("Basic", () => {
  test("foo=bar", () => {
    let res = Js.Dict.empty()
    Js.Dict.set(res, "foo", "bar")
    expect(parse(~str="foo=bar", ())) |> toEqual(res)
  })
  test("foo=123", () => {
    let res = Js.Dict.empty()
    Js.Dict.set(res, "foo", "123")
    expect(parse(~str="foo=123", ())) |> toEqual(res)
  })
})

test("Ignore spaces", () => {
  let res = Js.Dict.empty()
  Js.Dict.set(res, "foo", "123")
  Js.Dict.set(res, "baz", "228")
  expect(parse(~str="foo =         123; baz   =       228;", ())) |> toEqual(res)
})

test("Escaping", () => {
  let res = Js.Dict.empty()
  Js.Dict.set(res, "foo", "bar=123456789&name=Magic+Mouse")
  expect(parse(~str="foo=\"bar=123456789&name=Magic+Mouse\"", ())) |> toEqual(res)
})

test("Ignore non values", () => {
  let res = Js.Dict.empty()
  Js.Dict.set(res, "foo", "%1")
  Js.Dict.set(res, "bar", "bar")
  expect(parse(~str="foo=%1;bar=bar;HttpOnly;Secure", ())) |> toEqual(res)
})

test("foo=123 with custom decoder", () => {
  let res = Js.Dict.empty()
  Js.Dict.set(res, "foo", "123123")
  expect(parse(~str="foo=123", ~options={decode: Some(str => str ++ str)}, ())) |> toEqual(res)
})
