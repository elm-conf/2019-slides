module Logo exposing (logo)

import Css exposing (Style)
import Html.Styled as Html exposing (Html)
import Svg.Styled as Svg exposing (..)
import Svg.Styled.Attributes exposing (..)


logo : List Style -> Html msg
logo styles =
    svg
        [ viewBox "0 0 324 324"
        , css styles
        ]
        [ Svg.path
            [ d "M162 153l70-70H92zM9 0l70.265 70H232L161.734 0zm238.485 85l76.367 76.368-76.367 76.367-76.368-76.367zM324 144V0H180zm-171 17.999L0 9v306zM256 247l68 68V179zm-94-76L9 324h306z"
            , fill "#FF5F6D"
            ]
            []
        ]
