module MessageBox exposing (..)

import Html exposing (..)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)


type alias Model =
    { message : String
    , messages : List String
    }


type Msg
    = ChangeMessage String
    | PostMessage


init : Model
init =
    { message = ""
    , messages = []
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeMessage txt ->
            { model | message = txt }

        PostMessage ->
            let
                messageList =
                    model.message :: model.messages
            in
            { model | messages = messageList, message = "" }


view : Model -> Html Msg
view model =
    div []
        [ textarea [ placeholder "write your message here...", value model.message, onInput ChangeMessage ] []
        , button [ onClick PostMessage ] [ text "Post" ]
        ]
