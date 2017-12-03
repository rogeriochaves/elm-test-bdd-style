module BetterSpecs exposing (..)

import ElmTestBDDStyle exposing (..)
import Expect exposing (..)
import Expect.Extra exposing (..)
import Test exposing (..)


-- Those tests ensures that elm-test-bdd-style allows you to follow http://www.betterspecs.org/ guidelines


tests : Test
tests =
    describe "BetterSpecs Guidelines"
        [ describe "How to describe your methods - http://www.betterspecs.org/#describe"
            [ describe ".authenticate" [ it "_" pass ]
            , describe "#admin?" [ it "_" pass ]
            ]
        , describe "Use contexts - http://www.betterspecs.org/#contexts"
            [ context "when logged in"
                (Response LoggedIn)
                [ itIsExpected to respondWith 200
                ]
            , context "when logged out"
                (Response LoggedOut)
                [ itIsExpected to respondWith 401
                ]
            ]
        , describe "Keep your description short - http://www.betterspecs.org/#short"
            [ context "when not valid"
                UnprocessableEntity
                [ itIsExpected to respondWith 422
                ]
            ]
        , describe "Single expectation test - http://www.betterspecs.org/#single"
            [ context "when logged in"
                (Response LoggedIn)
                [ itIsExpected to respondWithContentType "json"
                , itIsExpected to assignTo "resource"
                ]
            , describe ".loggedIn"
                [ multipleIt "creates a resource"
                    [ expect (Response LoggedIn) to respondWithContentType "json"
                    , expect (Response LoggedIn) to assignTo "resource"
                    ]
                ]
            ]
        , describe "Test all possible cases - http://www.betterspecs.org/#all"
            [ describe "#destroy"
                [ context "when resouce is found"
                    (Response LoggedIn)
                    [ itIsExpected to respondWith 200
                    , itIsExpected to showResource True
                    ]
                , context "when resouce is not found"
                    NotFound
                    [ itIsExpected to respondWith 404
                    ]
                , context "when resouce is not owned"
                    NotOwned
                    [ itIsExpected to respondWith 404
                    ]
                ]
            ]
        , describe "Expect vs Should syntax - http://www.betterspecs.org/#expect"
            [ it "creates a resource" <|
                expect (Response LoggedIn) to respondWithContentType "json"
            , context "when not valid"
                UnprocessableEntity
                [ itIsExpected to respondWith 422
                ]
            ]
        , describe "Use subject - http://www.betterspecs.org/#subject"
            [ context "when using subject"
                (assigns .message)
                [ itIsExpected to match (stringPattern "it was born in Billville")
                ]
            , let
                hero =
                    { equipment = [ "sword", "shield" ] }
              in
              it "carries a sword" <|
                expect hero.equipment to contain "sword"
            ]
        , describe "Use let and let! - http://www.betterspecs.org/#let"
            [ describe "#typeId"
                (let
                    resource =
                        createResource

                    type_ =
                        findType resource.typeId
                 in
                 [ it "sets the typeId field" <|
                    expect resource.typeId to equal type_.id
                 ]
                )
            ]
        ]



-- Pseudo-implementation


type Response
    = Response AuthState
    | UnprocessableEntity
    | NotFound
    | NotOwned


type AuthState
    = LoggedIn
    | LoggedOut


statusCode : Response -> number
statusCode response =
    case response of
        Response LoggedIn ->
            200

        Response LoggedOut ->
            401

        UnprocessableEntity ->
            422

        NotFound ->
            404

        NotOwned ->
            404


contentType : Response -> String
contentType response =
    case response of
        Response _ ->
            "json"

        _ ->
            "text/html"


shouldShow : Response -> Bool
shouldShow response =
    case response of
        Response _ ->
            True

        _ ->
            False


createResource : { typeId : number }
createResource =
    { typeId = 6 }


findType : a -> { id : a }
findType id =
    { id = id }



-- Rspec like functions and matchers


context : String -> a -> List (String -> a -> Test) -> Test
context text subject fns =
    describe text <| List.indexedMap (\index fn -> fn ("expectation #" ++ toString (index + 1)) subject) fns


itIsExpected : Conjunction -> (a -> b -> Expectation) -> a -> String -> b -> Test
itIsExpected word matcher expected text subject =
    it text (expect subject word matcher expected)


multipleIt : String -> List Expectation -> Test
multipleIt text expectations =
    describe text <| List.indexedMap (\index -> it <| ("expectation #" ++ toString (index + 1))) expectations


respondWith : number -> Response -> Expectation
respondWith expected subject =
    statusCode subject
        |> equal expected


respondWithContentType : String -> Response -> Expectation
respondWithContentType expected subject =
    contentType subject
        |> equal expected


assignTo : a -> b -> Expectation
assignTo expected subject =
    True
        |> equal True


showResource : Bool -> Response -> Expectation
showResource expected subject =
    shouldShow subject
        |> equal expected


assigns selector =
    selector { message = "it was born in Billville" }
