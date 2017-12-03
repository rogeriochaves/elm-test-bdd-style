elm-test-bdd-style [![Build Status][ci-svg]][ci-url]
==================

[ci-svg]: https://circleci.com/gh/rogeriochaves/elm-test-bdd-style.svg?style=shield
[ci-url]: https://circleci.com/gh/rogeriochaves/elm-test-bdd-style

BDD style matchers on top of elm-test. It's a very simple syntax sugar.

## Getting started ##

First, follow the getting started steps from the [elm-test](https://github.com/elm-community/elm-test) package.

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
module Example exposing (..)

import Test exposing (..)
import Expect exposing (..)
import Fuzz exposing (..)
import ElmTestBDDStyle exposing (..)


tests : Test
tests =
    describe "Example Text"
        [ it "does math correctly" <|
            expect (1 + 1) to equal 2
        , it "does not miscalculate things" <|
            expect (2 + 2) to notEqual 5
        , it "exemplifies more complex test cases" <|
            let
                expression =
                    2 + 2
            in
                expect expression to equal 4
        , it "compares two numbers" <|
            expect (10 > 5) toBe true "math should work"
        , it "compares two numbers" <|
            expect 10 toBe greaterThan 5
        , fuzz (list int) "ends up with the same list when reversing twice" <|
            \fuzzList ->
                expect (List.reverse (List.reverse fuzzList)) to equal fuzzList
        ]
```

## Extending it ##

You can use [ktonon/elm-test-exta](http://package.elm-lang.org/packages/ktonon/elm-test-extra/1.6.2/Expect-Extra) for extra matchers such as `match` and `contain`.

You may also write your own matchers and other functions to make your tests as idiomatic as you want. For some examples, check out the `tests/BetterSpecs.elm` file on this project to see a reimplementation of [betterspecs.org](http://www.betterspecs.org/) in Elm.