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
        , headers = []
        , url = "http://localhost:8000"
        , body = Http.emptyBody
        , expect = expectSong msg
        , timeout = Just 5000
        , tracker = Nothing
        }


expectSong : (Result Http.Error Song -> msg) -> Http.Expect msg
expectSong msg =
    Http.expectJson msg
        (Decode.map3 Song
            (Decode.index 0 Decode.string)
            (Decode.index 1 Decode.string)
            (Decode.index 2 Decode.string)
        )
