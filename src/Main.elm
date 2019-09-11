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
    | GoBack
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

        GoBack ->
            ( case Zipper.previous slides of
                Nothing ->
                    Zipper.last slides

                Just prev ->
                    prev
            , Cmd.none
            )

        Keypress "f" ->
            ( slides
            , toggleFullscreen ()
            )

        Keypress "ArrowLeft" ->
            update GoBack slides

        Keypress "ArrowRight" ->
            update Advance slides

        Keypress _ ->
            ( slides, Cmd.none )


init : Flags -> ( Slides, Cmd Msg )
init msg =
    ( Zipper.fromCons
        Slide.Splash
        [ Slide.Info
            { title = "Code of Conduct"
            , text = "All attendees, speakers, sponsors, and volunteers at our conference are required to agree with and follow the code of conduct, available at https://thestrangeloop.com/policies.html"
            }
        , Slide.Image
            { src = "/hubtran.png"
            , title = "HubTran"
            , text = "HubTran is a fast-growing technology startup focused on automating work in the logistics industry. Through a combination of a powerful browser based interface and machine learning, we are able to reduce our customer's workload by 4x or more. HubTran believes that Elm is the future of the front end. Our front end is already more than 60% Elm and we're looking for engineers to join our 15 person remote friendly engineering team."
            }
            , text = "..."
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
            , Css.backgroundColor (Css.hex "FFF")
            , Css.backgroundImage (Css.url ("data:image/svg+xml;base64," ++ Waves.data))
            , Css.backgroundSize Css.cover
            , Css.borderTop3 (Css.vh 1) Css.solid (Css.hex "FF5F6D")
            , Css.displayFlex
            , Css.alignItems Css.center
            , Css.justifyContent Css.center
            ]
        ]
        [ Slide.view (Zipper.current slides)
        , wifi
        ]


wifi : Html msg
wifi =
    Html.p
        [ css
            [ Css.position Css.absolute
            , Css.bottom (Css.vh 2)
            , Css.right (Css.vw 2)
            , Css.fontSize (Css.vh 3)
            , Css.fontFamilies [ "Work Sans" ]
            , Css.textAlign Css.right
            , Css.lineHeight (Css.vh 4)
            ]
        ]
        [ Html.strong [ css [ Css.fontWeight (Css.int 700) ] ] [ Html.text "Wi-Fi: " ]
        , Html.text "Curio Meeting"
        , Html.br [] []
        , Html.strong [ css [ Css.fontWeight (Css.int 700) ] ] [ Html.text "Password: " ]
        , Html.text "1820"
        ]


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
