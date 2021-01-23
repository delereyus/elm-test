module Main exposing (Model, Msg, init, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)
import MessageBox exposing (..)
import Search exposing (..)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    { startValue : String
    , newValue : String
    , messageBox : MessageBox.Model
    , search : Search.Model
    }


init : Model
init =
    { startValue = "hej"
    , newValue = ""
    , messageBox = MessageBox.init
    , search = Search.init
    }


type Msg
    = ChangeText
    | ChangeNewValue String
    | MessageBoxMsg MessageBox.Msg
    | SearchMsg Search.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeText ->
            { model | startValue = model.newValue }

        ChangeNewValue val ->
            { model | newValue = val }

        MessageBoxMsg msg_ ->
            let
                newMessageBox =
                    MessageBox.update msg_ model.messageBox
            in
            { model | messageBox = newMessageBox }

        SearchMsg msg_ ->
            let
                newSearch =
                    Search.update msg_ model.search
            in
            { model | search = newSearch }


performSearch : Model -> List String
performSearch model =
    let
        newResults =
            if model.search.query /= "" then
                List.filter (\item -> String.contains model.search.query item) model.messageBox.messages

            else
                []
    in
    newResults


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ text model.startValue ]
        , div []
            [ input [ placeholder "write something", value model.newValue, onInput ChangeNewValue ] []
            , button [ onClick ChangeText ] [ text "press me" ]
            ]
        , section []
            [ Html.map MessageBoxMsg (MessageBox.view model.messageBox)
            ]
        , section []
            [ ul [] (List.map (\x -> li [] [ text x ]) model.messageBox.messages) ]
        , section []
            [ Html.map SearchMsg (Search.view model.search)
            , ul [] (List.map (\x -> li [] [ text x ]) (performSearch model))
            ]
        ]
