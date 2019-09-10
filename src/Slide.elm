module Slide exposing (..)

import Css exposing (rem)
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes exposing (css)


type Slide
    = Splash { title : String }
    | CenteredInfo { title : String, text : String }


view : Slide -> Html msg
view slide =
    case slide of
        Splash { title } ->
            Html.section []
                [ heading title ]

        CenteredInfo { title, text } ->
            Html.section []
                [ subHeading title
                , paragraph [ Html.text text ]
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
            ]
        ]
