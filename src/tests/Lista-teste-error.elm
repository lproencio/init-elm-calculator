module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Time


---- MODEL ----


type alias Model =
    { listas : List Lista
    }

type alias Tempo =
    { zone : Time.Zone
    , time : Time.Posix
    }

type alias Lista =
    {info : String}


init : ( Model, Cmd Msg )
init =
    ( { listas = [lista1, lista2, lista3] }, Cmd.none )

initTime : () -> ( Tempo, Cmd Msg)
initTime _ =
    ( Tempo Time.utc (Time.millisToPosix 0), Cmd.none)

lista1 : Lista
lista1 =
    Lista "a"

lista2 : Lista
lista2 =
    Lista "b"

lista3 : Lista
lista3 =
    Lista "c" 



---- UPDATE ----


type Msg
  = Loop


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Loop ->            
            (model, Cmd.none)
                         



---- VIEW ----
viewLista : Lista -> Html msg
viewLista lista =
     text lista.info 

view : Model -> Html Msg
view model =
    div 
      [ class "teste" ]
        [ text "hello"
        , div [] (List.map viewLista model.listas)
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
