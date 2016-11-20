port module Main exposing (..)

import Test.Runner.Node exposing (run, TestProgram)
import Example exposing (tests)
import Json.Encode exposing (Value)


main : TestProgram
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
