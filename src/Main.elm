port module Main exposing (main)

import Browser
import Browser.Events exposing (onKeyDown)
import Css
import Css.Global as Global
import Html as RootHtml
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attributes exposing (css)
import Json.Decode as Decode
import List.Zipper as Zipper exposing (Zipper)
import Slide exposing (Slide)
import Time
import Waves


port toggleFullscreen : () -> Cmd msg


type alias Slides =
    Zipper Slide


type Msg
    = Advance
    | Keypress String


type alias Flags =
    ()


update : Msg -> Slides -> ( Slides, Cmd Msg )
update msg slides =
    case msg of
        Advance ->
            ( case Zipper.next slides of
                Nothing ->
                    Zipper.first slides

                Just next ->
                    next
            , Cmd.none
            )

        Keypress "f" ->
            ( slides
            , toggleFullscreen ()
            )

        Keypress _ ->
            ( slides, Cmd.none )


init : Flags -> ( Slides, Cmd Msg )
init msg =
    ( Zipper.fromCons
        Slide.Splash
        [ Slide.CenteredInfo
            { title = "Code of Conduct"
            , text = "test test test test test test test test test test test test test test test test test test test test test test test test test test test"
            }
        ]
    , Cmd.none
    )


view : Slides -> Html Msg
view slides =
    Html.div
        [ css
            [ Css.width (Css.pct 100)
            , Css.height (Css.vh 100)
            , Css.backgroundImage (Css.url ("data:image/svg+xml;base64," ++ Waves.data))
            , Css.backgroundSize Css.cover
            , Css.borderTop3 (Css.vh 1) Css.solid (Css.hex "FF5F6D")
            , Css.displayFlex
            , Css.alignItems Css.center
            , Css.justifyContent Css.center
            ]
        ]
        [ Slide.view (Zipper.current slides) ]


main : Program Flags Slides Msg
main =
    Browser.document
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Slides"
                , body =
                    [ (Html.toUnstyled << Global.global) [ Global.everything [ Css.boxSizing Css.borderBox ] ]
                    , Html.toUnstyled (view model)
                    ]
                }
        , subscriptions =
            \_ ->
                Sub.batch
                    [ Time.every 7500 (\_ -> Advance)
                    , onKeyDown (Decode.map Keypress (Decode.field "key" Decode.string))
                    ]
        }
