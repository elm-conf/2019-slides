module Main exposing (main)

import Browser
import Html as RootHtml
import Html.Styled as Html exposing (Html)


type alias Model =
    ()


type alias Msg =
    ()


type alias Flags =
    ()


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


init : Flags -> ( Model, Cmd Msg )
init msg =
    ( (), Cmd.none )


view : Model -> Html Msg
view _ =
    Html.text "hey"


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Slides"
                , body = [ Html.toUnstyled (view model) ]
                }
        , subscriptions = \_ -> Sub.none
        }
