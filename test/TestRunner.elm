module Main where

import Task
import Graphics.Element exposing (Element)
import Console exposing (..)
import ElmTest exposing (Test, consoleRunner, elementRunner)

import Example exposing (tests)

main : Element
main =
    elementRunner tests

port runner : Signal (Task.Task x ())
port runner =
    Console.run <| consoleRunner tests
