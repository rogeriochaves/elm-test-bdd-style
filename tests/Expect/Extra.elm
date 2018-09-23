module Expect.Extra exposing
    ( match, MatchPattern, stringPattern, regexPattern
    , contain, member
    )

{-| Extends `Expect` with more `Expectation`s.


## Strings

@docs match, MatchPattern, stringPattern, regexPattern


## Lists

@docs contain, member

-}

import Expect exposing (..)
import Regex exposing (Regex)


{-| An expectation represented as a pattern to match a string.
-}
type MatchPattern
    = StringPattern String
    | RegexPattern String


{-| Matches if the pattern is contained within the actual string value.
-}
stringPattern : String -> MatchPattern
stringPattern =
    StringPattern


{-| Matches if the regular expression matches the actual string value.
-}
regexPattern : String -> MatchPattern
regexPattern =
    RegexPattern


{-| Passes if the given pattern matches the actual string.
-- Match with regular expressions
match (regexPattern "^[0-9a-f]+$") "deadbeef"
-- Or just plain strings
match (stringPattern "foo") "foo bar"
-}
match : MatchPattern -> String -> Expectation
match expected actual =
    case expected of
        StringPattern pattern ->
            Expect.true ("\"" ++ actual ++ "\" to contain sub-string: " ++ pattern) <|
                String.contains pattern actual

        RegexPattern pattern ->
            Expect.true ("\"" ++ actual ++ "\" to match regex: " ++ pattern) <|
                Regex.contains (Maybe.withDefault Regex.never <| Regex.fromString pattern ) actual


{-| Passes if value is a member of list.
member 1 [0, 1, 2]
-- Passes because 1 is a member of [0, 1, 2]
-}
member : a -> List a -> Expectation
member value list =
    if List.member value list then
        pass

    else
        fail
            ("Expected:\n  "
                ++ Debug.toString list
                ++ "\nto contain:\n  "
                ++ Debug.toString value
            )


{-| Alias of `member`.
Reads better with bdd style tests.
expect [0, 1, 2] to contain 1
-- Passes because [0, 1, 2] contains 1
-}
contain : a -> List a -> Expectation
contain =
    member
