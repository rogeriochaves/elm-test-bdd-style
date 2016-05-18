module Main exposing (..)

import ElmTest exposing (..)
import Example exposing (tests)


main : Program Never
main =
    runSuite tests
