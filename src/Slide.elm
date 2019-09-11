module Slide exposing (..)

import Css exposing (rem)
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attributes exposing (css)
import Logo


type Slide
    = Splash
    | Info { title : String, text : String }
    | Image { src : String, title : String, text : String }


view : Slide -> Html msg
view slide =
    case slide of
        Splash ->
            Html.section
                [ css
                    [ Css.displayFlex
                    , Css.flexDirection Css.column
                    , Css.alignItems Css.center
                    ]
                ]
                [ Logo.logo
                    [ Css.height (Css.vh 25)
                    , Css.marginBottom (Css.vh 3)
                    ]
                , heading "elm-conf 2019"
                ]

        Info { title, text } ->
            Html.section []
                [ subHeading title
                , paragraph [ Html.text text ]
                ]

        Image { src, title, text } ->
            Html.section
                [ css
                    [ Css.displayFlex
                    , Css.maxWidth (Css.vw 61.803)
                    ]
                ]
                [ Html.div
                    [ css
                        [ Css.margin (Css.vh 4)
                        , Css.width (Css.pct (100 - 61.803))
                        , Css.height Css.auto
                        , Css.displayFlex
                        , Css.alignItems Css.center
                        ]
                    ]
                    [ Html.img
                        [ Attributes.src src
                        , Attributes.alt title
                        , css [ Css.width (Css.pct 100) ]
                        ]
                        []
                    ]
                , Html.div
                    [ css
                        [ Css.width (Css.pct 61.803)
                        , Css.displayFlex
                        , Css.flexDirection Css.column
                        , Css.justifyContent Css.center
                        ]
                    ]
                    [ subHeading title
                    , paragraph [ Html.text text ]
                    ]
                ]


heading : String -> Html msg
heading text =
    Html.h1
        [ css
            [ Css.fontSize (Css.vh 12)
            , Css.fontFamilies [ "Vollkorn" ]
            , Css.color (Css.hex "FF5F6D")
            , Css.marginBottom (Css.vh 2)
            ]
        ]
        [ Html.text text ]


subHeading : String -> Html msg
subHeading text =
    Html.h1
        [ css
            [ Css.fontSize (Css.vh 8)
            , Css.fontFamilies [ "Vollkorn" ]
            , Css.color (Css.hex "FF5F6D")
            , Css.marginBottom (Css.vh 2)
            ]
        ]
        [ Html.text text ]


paragraph : List (Html msg) -> Html msg
paragraph =
    Html.p
        [ css
            [ Css.fontFamilies [ "Work Sans" ]
            , Css.fontSize (Css.vh 3)
            , Css.color (Css.hex "444")
            , Css.maxWidth (Css.vw 61.803)
            , Css.lineHeight (Css.vh 5)
            ]
        ]
