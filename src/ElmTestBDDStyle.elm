module ElmTestBDDStyle
  (Test, Assertion, describe, it
  , expect, toBe, notToBe, toBeTruthy
  , itAlways, expectThat, isTheSameAs, forEvery) where

{-| BDD style functions for ElmTest

# Tests
@docs Test, Assertion, describe, it

# Matchers
@docs expect, toBe, notToBe, toBeTruthy

# Property-based testing
@docs itAlways, expectThat, isTheSameAs, forEvery

-}

import ElmTest exposing (Test, suite, test, assert, assertEqual, assertNotEqual)
import Check.Test as CheckTest
import Check.Investigator exposing (Investigator)
import Random exposing (initialSeed)

{-| The basic unit of testability. -}
type alias Test = ElmTest.Test

{-| Assertion type, use that for building custom matchers -}
type alias Assertion = ElmTest.Assertion

{-| A group of related behaviours specs -}
describe : String -> List Test -> Test
describe = suite

{-| Describes a behaviour you expect from your code -}
it : String -> Assertion -> Test
it = test

{-| Expectation to actually run the test, it receives
two values and try to match then with a matcher -}
expect : a -> (a -> b) -> b
expect actual matchs = matchs actual

{-| Expect something to be equals something else -}
toBe : a -> a -> Assertion
toBe = assertEqual

{-| Expect something not to be equals something else -}
notToBe : a -> a -> Assertion
notToBe = assertNotEqual

{-| Expect something to be true -}
toBeTruthy : Bool -> Assertion
toBeTruthy = assert

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
