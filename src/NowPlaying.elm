module NowPlaying exposing (..)

import Http
import Json.Decode as Decode


type alias Song =
    { title : String
    , artist : String
    , albumCoverUrl : String
    }


get : String -> (Result Http.Error Song -> msg) -> Cmd msg
get token msg =
    Http.request
        { method = "GET"
        , headers =
            [ Http.header "Accept" "application/json"
            , Http.header "Authorization" ("Bearer " ++ token)
            ]
        , url = "https://api.spotify.com/v1/me/player/currently-playing"
        , body = Http.emptyBody
        , expect = expectSong msg
        , timeout = Just 5000
        , tracker = Nothing
        }


expectSong : (Result Http.Error Song -> msg) -> Http.Expect msg
expectSong msg =
    Http.expectJson msg
        (Decode.map3 Song
            (Decode.at [ "item", "name" ] Decode.string)
            (Decode.at [ "item", "album", "artists" ] (Decode.index 0 (Decode.field "name" Decode.string)))
            (Decode.at [ "item", "album", "images" ] (Decode.index 1 (Decode.field "url" Decode.string)))
        )
