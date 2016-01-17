module ElmTestBDDStyle (Test, describe, it, expect, toBe, notToBe) where

{-| BDD style functions for ElmTest

# Tests
@docs Test, describe, it

# matchers
@docs expect, toBe, notToBe

-}

import ElmTest exposing (Test, Assertion, suite, test, assert)

{-| The basic unit of testability. -}
type alias Test = ElmTest.Test

{-| A group of related behaviours specs -}
describe : String -> List Test -> Test
describe = suite

{-| Describes a behaviour you expect from your code -}
it : String -> Assertion -> Test
it = test

{-| Expectation to actually run the test, it receives
two values and try to match then with a matcher -}
expect : a -> (a -> b -> Bool) -> b -> Assertion
expect actual matchs expected = assert <| actual `matchs` expected

{-| Expect something to be equals something else -}
toBe : a -> a -> Bool
toBe = (==)

{-| Expect something not to be equals something else -}
notToBe : a -> a -> Bool
notToBe = (<<) not << toBe
