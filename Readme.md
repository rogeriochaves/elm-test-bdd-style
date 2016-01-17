elm-test-bdd-style [![Build Status][snap-svg]][snap-url]
==================

[snap-svg]: https://snap-ci.com/rogeriochaves/elm-test-bdd-style/branch/master/build_image.svg
[snap-url]: https://snap-ci.com/rogeriochaves/elm-test-bdd-style/branch/master

BDD style matchers on top of elm-test

## Getting started ##

First, follow the getting started steps from the [elm-test](https://github.com/deadfoxygrandpa/elm-test) package.

Then, install elm-test-bdd-style:

```
elm package install rogeriochaves/elm-test-bdd-style
```

To use it, just import it on your test:

```elm
import ElmTestBDDStyle exposing (..)
```

## Usage example ##

```elm
-- Example.elm
module Example where

import ElmTestBDDStyle exposing (..)

tests : Test
tests =
  describe "Example Text"
    [ it "does math correctly" <|
        expect (1 + 1) toBe 2

    , it "does not miscalculate things" <|
        expect (2 + 2) notToBe 5

    , it "exemplifies more complex test cases" <|
        let
          expression = 2 + 2
        in
          expect expression toBe 4
    ]
```

Right now, elm-test-bdd-style comes only with `toBe` and `notToBe`, but it is very easy to create your own matchers:

```elm
toBeGreaterThan : comparable -> comparable -> Bool
toBeGreaterThan = (>)

tests : Test
tests =
  describe "Custom matchers"
    [ it "compares two numbers" <|
        expect 10 toBeGreaterThan 5
    ]
```
