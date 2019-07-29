module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (src, placeholder, value, class)


-- Model -- 
type alias Nome =
  { nome : String }

type alias Senha =
  { senha : String }

first : Nome
first =
  Nome "nome" 

senha : Senha
senha = 
  Senha"senha"

type alias Model =
  { name : String
  , password : String
  , validation : Validation
  }

type Validation 
    = NotDone
    | Validation
    | Error String
     

init : ( Model, Cmd Msg )
init = 
  ({ name = "", password = "", validation = NotDone }, Cmd.none)

-- UpDate --
type Msg 
     = Name String
     | Password String
     | Login

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
      Name name ->          
        ({ model | name = name }, Cmd.none)

      Password password ->
        ({ model | password = password }, Cmd.none)

      Login ->
        ({ model | validation = validate model }, Cmd.none)

validate : Model -> Validation
validate model =
  if ( model.name /= first.nome || model.password /= senha.senha) then
    Error "Pass or name no match"
  else
    Validation


-- View --
viewConfirm : Model -> Html Msg
viewConfirm model =
  let
    (message) =
      case model.validation of
        NotDone -> ("")
        Error textSms -> (textSms)
        Validation -> ("Success")
  in
    div[ class "confirm" ] [text message]
  


view : Model -> Html Msg
view model =
  div []
      [ h1 [] [ text "titulo" ]
      , input [ placeholder "user", value model.name, onInput Name ] []
      , input [ placeholder "password", value model.password, onInput Password ] []
      , button [onClick Login ] [ text "login" ]
      , viewConfirm model 
      ]


-- Main --
main : Program () Model Msg
main =
    Browser.element
      { view = view
      , init = \_ -> init
      , update = update
      , subscriptions = always Sub.none
      }