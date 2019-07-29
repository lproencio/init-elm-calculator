module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (src)


---- MODEL ----


type alias Model =
    {listas : List Lista  }

type alias Lista =
    {info : String}


init : ( Model, Cmd Msg )
init =
    ( { listas = [lista1] }, Cmd.none )


lista1 : Lista
lista1 =
    Lista "a" 


---- UPDATE ----


type Msg
    = Loop
    | BuildList

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    (model, Cmd.none)
                         



---- VIEW ----
viewLista : Lista -> Html msg
viewLista lista =
    li []
        [ text lista.info]

view : Model -> Html Msg
view model =
    div [onClick Loop]
        [ text "hello"
        , ul [] (List.map viewLista model.listas)
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
