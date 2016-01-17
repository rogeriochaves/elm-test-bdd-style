module Example where

import ElmTestBDDStyle exposing (..)
import Check.Investigator exposing (..)

toBeGreaterThan : comparable -> comparable -> Bool
toBeGreaterThan = (>)

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
        expect 10 toBeGreaterThan 5

    , itAlways "ends up with the same list when reversing twice" <|
        expectEach
          (\list -> List.reverse (List.reverse list))
        toBeTheSameAs
          (identity)
        forEvery
          (list int)
    ]
