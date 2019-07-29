module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (src, placeholder, value, class)


-- Model --
type alias Calculo =
  { soma : Float -> Float -> Float
  , subt : Float -> Float -> Float
  , div : Float -> Float -> Float
  , mult : Float -> Float -> Float
  }


calculo : Calculo
calculo = 
  { soma = (\x y -> x + y)
  , subt = (\x y -> x - y )
  , div = (\x y -> x / y )
  , mult = (\x y -> x * y )
  }

type alias Model =
  { display : String
  , function : Float -> Float -> Float
  , lastValue : Float
  , append : Bool
  }

init :  Model
init =
  { display = ""
  , function = (\x y -> y)
  , lastValue = 0
  , append = True
  }

parseFloat : String -> Float
parseFloat input = 
  Maybe.withDefault 0 (String.toFloat input)

operation : Model -> (Float -> Float -> Float) -> Model
operation model function =
  { model
        | function = function
        , lastValue = (parseFloat model.display)
        , append = False        
  }

-- Update --
type Msg
  = None
  | Soma
  | Subt
  | Div
  | Mult
  | Equal
  | Decimal
  | Zero
  | Number Int
  | Clear

    
update : Msg -> Model -> Model
update msg model = 
  case msg of
      None ->
          model

      Clear ->
        init

      Number number ->
        updateDisplay model number

      Decimal -> 
        decimal model

      Zero ->
        zero model

      Soma -> 
        operation model calculo.soma

      Subt ->
        operation model calculo.subt

      Div ->
        operation model calculo.div

      Mult ->
        operation model calculo.mult

      Equal ->
        equal model


updateDisplay : Model -> Int -> Model
updateDisplay model number =
  if model.append then
    {model | display = model.display ++ String.fromInt (number) }
  else
    { model | display = String.fromInt (number), append = True }


equal : Model -> Model
equal model =
  if model.append then
    { model
          | display = calculadora model
          , lastValue = (parseFloat model.display)
          , append = False
    }
  else
    { model | display = calculadora model, append = False}
          

calculadora : Model -> String
calculadora model =
  model.function model.lastValue (parseFloat model.display) |> String.fromFloat

zero : Model -> Model
zero model =
  if String.isEmpty model.display || not model.append then
    { model 
          | display = "0"
          , append = False
    }
  else
    { model | display = model.display ++ "0" }

decimal : Model -> Model
decimal model =
  if not (String.isEmpty model.display) && model.append then
    { model | display = appendDecimal model.display }
  else
    { model | display =  "0.", append = True }

appendDecimal : String -> String
appendDecimal string =
  if String.contains "." string then
    string
  else
    string ++ "."


-- View --
calculoButton : Msg -> String -> Html Msg
calculoButton msg buttonText =
  button [ class "button", onClick msg]
         [ span [] 
                [ buttonText |> text ]
         ]

calculoButtonWide : Msg -> String -> Html Msg
calculoButtonWide msg buttonText =
  button [ class "wide", onClick msg]
         [ span [] 
                [ buttonText |> text ]
         ]
  

view : Model -> Html Msg
view model =
  div [ class "div-main"]
      [ div [ class "calculator"]
            [ div [ class "display" ]
                  [ div [ class "display-text" ]
                        [ text ( model.display ) ] 
                  ]
              , div [ class "buttons" ] 
                    [div [ class "clear"]
                         [ calculoButtonWide Clear "clear" ]   
                    , div [ class "row"] 
                          [ calculoButton (Number 7) "7"
                          , calculoButton (Number 8) "8"
                          , calculoButton (Number 9) "9"
                          , calculoButton Soma "+"]
                    , div [ class "row"] 
                          [ calculoButton (Number 4) "4"
                          , calculoButton (Number 5) "5"
                          , calculoButton (Number 6) "6"
                          , calculoButton Mult "x" ]
                    , div [ class "row"]                   
                          [ calculoButton (Number 1) "1"
                          , calculoButton (Number 2) "2"
                          , calculoButton (Number 3) "3"
                          , calculoButton Subt "-" ]
                    , div [ class "row"]               
                          [ calculoButton Zero "0"
                          , calculoButton Decimal "."
                          , calculoButton Equal "="
                          , calculoButton Div "/" ]
                    ]
            ]
       ] 


-- Main --

main =
    Browser.sandbox
      { view = view
      , init = init
      , update = update
      }