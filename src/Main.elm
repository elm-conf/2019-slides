port module Main exposing (main)

import Browser
import Browser.Events exposing (onKeyDown)
import Css
import Css.Global as Global
import Html as RootHtml
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attributes exposing (css)
import Http
import Json.Decode as Decode
import List.Zipper as Zipper exposing (Zipper)
import Logo
import NowPlaying exposing (Song)
import Slide exposing (Slide)
import Time
import Waves


port toggleFullscreen : () -> Cmd msg


type alias Model =
    { slides : Zipper Slide
    , nowPlaying : Maybe Song
    }


type Msg
    = Advance
    | GoBack
    | Keypress String
    | RefreshNowPlaying
    | NewNowPlaying (Result Http.Error Song)


type alias Flags =
    ()


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Advance ->
            ( { model
                | slides =
                    case Zipper.next model.slides of
                        Nothing ->
                            Zipper.first model.slides

                        Just next ->
                            next
              }
            , Cmd.none
            )

        GoBack ->
            ( { model
                | slides =
                    case Zipper.previous model.slides of
                        Nothing ->
                            Zipper.last model.slides

                        Just prev ->
                            prev
              }
            , Cmd.none
            )

        Keypress "f" ->
            ( model
            , toggleFullscreen ()
            )

        Keypress "ArrowLeft" ->
            update GoBack model

        Keypress "ArrowRight" ->
            update Advance model

        Keypress _ ->
            ( model, Cmd.none )

        RefreshNowPlaying ->
            ( model
            , NowPlaying.get NewNowPlaying
            )

        NewNowPlaying (Ok song) ->
            ( { model | nowPlaying = Just song }
            , Cmd.none
            )

        NewNowPlaying _ ->
            ( { model | nowPlaying = Nothing }
            , Cmd.none
            )


init : Flags -> ( Model, Cmd Msg )
init msg =
    ( { slides =
            Zipper.fromCons
                Slide.Splash
                [ Slide.Info
                    { title = "Captioning"
                    , text = "You can stream captions to your laptop or phone. Set whatever text size and colors you like! http://bit.ly/elm-captions-2019"
                    }
                , Slide.Info
                    { title = "Code of Conduct"
                    , text = "All attendees, speakers, sponsors, and volunteers at our conference are required to agree with and follow the code of conduct, available at https://thestrangeloop.com/policies.html"
                    }
                , Slide.Image
                    { src = "/programming-elm.jpg"
                    , title = "Programming Elm"
                    , text = "elm-conf attendees can get 20% off an ebook copy of Programming Elm by entering code \"elmconf_jfelm_2019\" at checkout: http://bit.ly/programming-elm"
                    }
                , Slide.Info
                    { title = "Party"
                    , text = "Please join us at 7pm tonight for the Strange Loop party at City Museum. Shuttles will run between conference hotels (Union Station/Drury Inn, Hilton Ballpark, and Pear Tree Inn) and City Museum. Badges are not required, and family/friends are welcome to attend. Bring durable clothes and shoes if you plan to climb!"
                    }
                , Slide.Image
                    { src = "/hubtran.png"
                    , title = "HubTran"
                    , text = "HubTran is a fast-growing technology startup focused on automating work in the logistics industry. Through a combination of a powerful browser based interface and machine learning, we are able to reduce our customer's workload by 4x or more. HubTran believes that Elm is the future of the front end. Our front end is already more than 60% Elm and we're looking for engineers to join our 15 person remote friendly engineering team."
                    }
                , Slide.Info
                    { title = "Lunch"
                    , text = "Shuttles will run between 20th Street and downtown restaurant areas. Food trucks at Union Station are only available for PWLConf attendees."
                    }
                , Slide.Info
                    { title = "Joel Clermont"
                    , text = "Thank you to Joel Clermont for providing community sponsorship for elm-conf."
                    }
                , Slide.Info
                    { title = "Elm in Action"
                    , text = "elm-conf attendees can get 40% off Manning books and videos (including Elm in Action) by using the code \"ctwelfconfus19\"."
                    }
                ]
      , nowPlaying = Nothing
      }
    , NowPlaying.get NewNowPlaying
    )


view : Model -> Html Msg
view model =
    Html.div
        [ css
            [ Css.width (Css.pct 100)
            , Css.height (Css.vh 100)
            , Css.backgroundColor (Css.hex "FFF")
            , Css.backgroundImage (Css.url ("data:image/svg+xml;base64," ++ Waves.data))
            , Css.backgroundSize Css.cover
            , Css.borderTop3 (Css.vh 3) Css.solid (Css.hex "FF5F6D")
            , Css.displayFlex
            , Css.alignItems Css.center
            , Css.justifyContent Css.center
            ]
        ]
        [ Slide.view (Zipper.current model.slides)
        , wifi
        , nowPlaying model.nowPlaying
        ]


wifi : Html msg
wifi =
    Html.p
        [ css
            [ Css.position Css.absolute
            , Css.bottom (Css.vh 4)
            , Css.right (Css.vw 4)
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


nowPlaying : Maybe Song -> Html msg
nowPlaying maybeSong =
    case maybeSong of
        Nothing ->
            Html.text ""

        Just song ->
            Html.div
                [ css
                    [ Css.position Css.absolute
                    , Css.bottom (Css.vh 4)
                    , Css.left (Css.vw 4)
                    , Css.displayFlex
                    , Css.alignItems Css.center
                    ]
                ]
                [ Html.div
                    [ css
                        [ Css.height (Css.vh 10)
                        , Css.width (Css.vh 10)
                        , Css.marginRight (Css.vh 2)
                        ]
                    ]
                    [ case song.albumCoverUrl of
                        "missing value" ->
                            Logo.logo [ Css.borderRadius (Css.pct 20) ]

                        _ ->
                            Html.img
                                [ Attributes.src song.albumCoverUrl
                                , css
                                    [ Css.width (Css.pct 100)
                                    , Css.borderRadius (Css.pct 20)
                                    ]
                                ]
                                []
                    ]
                , Html.p
                    [ css
                        [ Css.fontFamilies [ "Work Sans" ]
                        , Css.fontSize (Css.vh 3)
                        , Css.lineHeight (Css.vh 4)
                        ]
                    ]
                    [ Html.strong [ css [ Css.fontWeight (Css.int 700) ] ] [ Html.text song.title ]
                    , Html.br [] []
                    , Html.text song.artist
                    ]
                ]


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Slides"
                , body =
                    [ (Html.toUnstyled << Global.global)
                        [ Global.everything
                            [ Css.boxSizing Css.borderBox
                            , Css.cursor Css.none
                            ]
                        ]
                    , Html.toUnstyled (view model)
                    ]
                }
        , subscriptions =
            \_ ->
                Sub.batch
                    [ Time.every 15000 (\_ -> Advance)
                    , Time.every 10000 (\_ -> RefreshNowPlaying)
                    , onKeyDown (Decode.map Keypress (Decode.field "key" Decode.string))
                    ]
        }
