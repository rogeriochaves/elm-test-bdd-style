module ElmTestBDDStyle
    exposing
        ( it
        , expect
        , to
        , toBe
        )

{-| BDD style functions for ElmTest

@docs it, expect, to, toBe

-}

import Test exposing (Test, describe, test, fuzz)
import Expect exposing (Expectation, equal, notEqual, true, false)


{-| Describes a behaviour you expect from your code
-}
it : String -> Expectation -> Test
it description expectation =
    test description (always expectation)


{-| Words just to make the tests more idiomatic
-}
type Conjunction
    = Word


{-| Expectation to actually run the test, it receives
two values and try to match then with a matcher
-}
expect : a -> Conjunction -> (a -> b) -> b
expect actual _ matcher =
    matcher actual


{-| Just a word to make it more idiomatic
-}
to : Conjunction
to =
    Word


{-| Just a word to make it more idiomatic
-}
toBe : Conjunction
toBe =
    Word
