module Search exposing (..)

import Html exposing (..)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onInput)


type alias Model =
    { query : String
    }


init : Model
init =
    { query = ""
    }


type Msg
    = ChangeQuery String


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeQuery txt ->
            { model | query = txt }


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Search messages...", value model.query, onInput ChangeQuery ] [] ]
