type serializeOptions = {
  domain: option<string>,
  encode: option<string => string>,
  expires: option<Js.Date.t>,
  httpOnly: option<bool>,
  maxAge: option<int>,
  path: option<string>,
  sameSite: option<string>,
  secure: option<bool>,
}

type rec cookieParseOptions = {decode: option<decoder>} and decoder = string => string

let unwrapOptWithDefault = (optionalValue, default) =>
  switch optionalValue {
  | Some(v) => v
  | None => default
  }

@module("cookie")
external parseInternal: (string, cookieParseOptions) => Js.Dict.t<string> = "parse"

@module("cookie")
external serializeInternal: (string, string, serializeOptions) => string = "serialize"

let parse = (~str: string, ~options=?, ()) => {
  parseInternal(str, unwrapOptWithDefault(options, {decode: None}))
}

let serialize = (
  ~name: string,
  ~value: string,
  ~domain=?,
  ~encode=?,
  ~expires=?,
  ~httpOnly=?,
  ~maxAge=?,
  ~path=?,
  ~sameSite=?,
  ~secure=?,
  (),
) => {
  serializeInternal(
    name,
    value,
    {
      domain: unwrapOptWithDefault(domain, None),
      encode: unwrapOptWithDefault(encode, None),
      expires: unwrapOptWithDefault(expires, None),
      httpOnly: unwrapOptWithDefault(httpOnly, None),
      maxAge: unwrapOptWithDefault(maxAge, None),
      path: unwrapOptWithDefault(path, None),
      sameSite: unwrapOptWithDefault(sameSite, None),
      secure: unwrapOptWithDefault(secure, None),
    },
  )
}
