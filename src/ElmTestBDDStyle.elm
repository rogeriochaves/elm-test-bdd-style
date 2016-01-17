module ElmTestBDDStyle
  (Test, describe, it
  , expect, toBe, notToBe
  , itAlways, expectThat, isTheSameAs, forEvery) where

{-| BDD style functions for ElmTest

# Tests
@docs Test, describe, it

# Matchers
@docs expect, toBe, notToBe

# Property-based testing
@docs itAlways, expectThat, isTheSameAs, forEvery

-}

import ElmTest exposing (Test, Assertion, suite, test, assert)
import Check.Test as CheckTest
import Check.Investigator exposing (Investigator)
import Random exposing (initialSeed)

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

{-| Words just to make the tests more idiomatic -}
type Conjunction = Word

{-| Idiomatic word helper -}
isTheSameAs : Conjunction
isTheSameAs = Word

{-| Idiomatic word helper -}
forEvery : Conjunction
forEvery = Word

{-| Adds a description to the random generated tests -}
itAlways : String -> (String -> Test) -> Test
itAlways description expectation =
  expectation description

{-| Generates a hundred tests with random input beginning with the initial seed 1 -}
expectThat : (a -> b) -> Conjunction -> (a -> b) -> Conjunction -> Investigator a -> String -> Test
expectThat function _ checker _ investigator description =
  CheckTest.test description function checker investigator 100 (initialSeed 1)
