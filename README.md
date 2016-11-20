elm-test-bdd-style [![Build Status][snap-svg]][snap-url]
==================

[snap-svg]: https://snap-ci.com/rogeriochaves/elm-test-bdd-style/branch/master/build_image.svg
[snap-url]: https://snap-ci.com/rogeriochaves/elm-test-bdd-style/branch/master

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
