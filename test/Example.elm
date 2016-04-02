module Example where

import ElmTestBDDStyle exposing (..)
import Check.Investigator exposing (..)

toBeGreaterThan : comparable -> comparable -> Assertion
toBeGreaterThan a b = (a > b) |> toBeTruthy

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

    , it "compares two numbers" <|
        expect (10 > 5) toBeTruthy

    , it "compares two numbers with a custom matcher" <|
        expect 10 toBeGreaterThan 5

    , itAlways "ends up with the same list when reversing twice" <|
        expectThat
          (\list -> List.reverse (List.reverse list))
        isTheSameAs
          (identity)
        forEvery
          (list int)
    ]
