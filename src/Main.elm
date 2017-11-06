module Main exposing (main)

import Accessibility as Html exposing (Html, div, h1, text)
import Css exposing (margin, px)
import Css.Namespace
import Html as H exposing (node)
import Html.CssHelpers


---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


{ class } =
    Html.CssHelpers.withNamespace namespace


view : Model -> Html Msg
view model =
    div []
        [ node "style" [] [ text (Css.compile [ css ] |> .css) ]
        , h1 [ class [ NavBar ] ] [ text "Your Elm App is working!" ]
        ]



---- STYLES ----


namespace : String
namespace =
    "npvConference"


type CssClasses
    = NavBar


css : Css.Stylesheet
css =
    (Css.stylesheet << Css.Namespace.namespace namespace)
        [ Css.class NavBar
            [ margin (px 10)
            ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
