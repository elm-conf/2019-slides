module Slide exposing (..)

import Css exposing (rem)
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes exposing (css)


type Slide
    = CenteredInfo { title : String, text : String }


view : Slide -> Html msg
view slide =
    case slide of
        CenteredInfo { title, text } ->
            Html.section []
                [ heading title
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


paragraph : List (Html msg) -> Html msg
paragraph =
    Html.p
        [ css
            [ Css.fontFamilies [ "Work Sans" ]
            , Css.fontSize (Css.vh 5)
            , Css.color (Css.hex "444")
            ]
        ]
