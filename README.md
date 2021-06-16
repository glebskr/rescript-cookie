
<div align="center">
<h1>rescript-cookie</h1>
<img width="140px" src="https://img.icons8.com/ios/452/cookie.png"></img>
<br>
</br>

ReScript Bindings for <a href="https://github.com/jshttp/cookie">Cookie</a>, basic cookie parser and serializer.
</div>

## Installation


1. Install package from npm:
   ```
   npm install --save rescript-cookie
   ```

   or

   ```
   yarn add rescript-cookie
   ```

2. Add `rescript-url` to `bs-dependencies` section of `bsconfig.json`:
   ```
   "bs-dependencies": [
    "rescript-cookie"
    ]
   ```

## Usage

### Parse

```reason
open Cookie

let cookie = parse(~str="foo=bar", ())
cookie // {"foo": "bar"}

// with spaces
let cookie = parse(~str="foo =         123; baz   =       228;", ())
cookie // {"foo": 123, "baz": 228}

// custom decoder
let cookie = parse(~str="foo=bar", ~options={decode: Some(str => str ++ str)} ())
cookie // {"foo": "barbar"}
```

### Serialize

```reason
open Cookie

let cookie = serialize(~name="foo", ~value="bar", ())
cookie // "foo=bar"

// secure option
let cookie = serialize(~name="foo", ~value="bar", ~secure=Some(true), ())
cookie // "foo=bar; Secure"

// domain option
let cookie = serialize(~name="foo", ~value="bar", ~secure=Some(true), ~domain=Some("example.com"), ())
cookie // "foo=bar; Secure; Domain=example.com"

// sameSite option
let cookie = serialize(~name="foo", ~value="bar", ~sameSite=Some("Strict"), ())
cookie // "foo=bar; SameSite=Strict"
```

### More usage examples
+ [Tests](https://github.com/glebskr/rescript-cookie/tree/master/__tests__)
