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
                , Html.p [] [ Html.text text ]
                ]


heading : String -> Html msg
heading text =
    Html.h1
        [ css
            [ Css.fontSize (rem 10)
            , Css.fontFamilies [ "Vollkorn" ]
            ]
        ]
        [ Html.text text ]
