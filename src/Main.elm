module Main exposing (main)

import Browser
import Html as RootHtml
import Html.Styled as Html exposing (Html)
import List.Zipper as Zipper exposing (Zipper)
import Slide exposing (Slide)


type alias Slides =
    Zipper Slide


type alias Msg =
    ()


type alias Flags =
    ()


update : Msg -> Slides -> ( Slides, Cmd Msg )
update msg model =
    ( model, Cmd.none )


init : Flags -> ( Slides, Cmd Msg )
init msg =
    ( Zipper.singleton (Slide.CenteredInfo { title = "Welcome to elm-conf", text = "YOOOOOO" })
    , Cmd.none
    )


view : Slides -> Html Msg
view slides =
    Slide.view (Zipper.current slides)


main : Program Flags Slides Msg
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
