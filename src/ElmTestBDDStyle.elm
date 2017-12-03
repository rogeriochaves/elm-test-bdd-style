module ElmTestBDDStyle
    exposing
        ( Conjunction(..)
        , expect
        , it
        , to
        , toBe
        )

{-| BDD style functions for ElmTest

@docs it, expect, to, toBe, Conjunction

-}

import Expect exposing (Expectation, equal, false, notEqual, true)
import Test exposing (Test, describe, fuzz, test)


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
expect : a -> Conjunction -> (b -> a -> Expectation) -> b -> Expectation
expect actual _ matcher =
    flip matcher actual


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
