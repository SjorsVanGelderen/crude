module Main exposing (main)



import Browser


import Html          exposing ( Html, div, text )
import Specification exposing ( Specification )


import ApplicationSpecification exposing ( applicationSpecification )



-- APPLICATION

main =
    Browser.element
        { init          = init
        , view          = view
        , update        = update
        , subscriptions = subscriptions
        }


        
-- MODEL

type alias Model =
    { 
    }


modelZero : Model
modelZero =
    {
    }


init : () -> (Model, Cmd Msg)
init flags =
    ( modelZero
    , Cmd.none
    )


    
-- UPDATE

type Msg
    = Nothing


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Nothing ->
            ( model
            , Cmd.none
            )



-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW

view : Model -> Html Msg
view model = div [] [ text "Hello, World!" ]
