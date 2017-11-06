module Main exposing (main)

import Accessibility as Html exposing (Html)
import Css
import Css.Namespace
import Html as CoreHtml
import Html.Attributes as Attrs
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


type Section
    = Home
    | About
    | Speakers
    | Location
    | Tickets


sections : List Section
sections =
    [ Home
    , About
    , Speakers
    , Location
    , Tickets
    ]


view : Model -> Html Msg
view model =
    Html.div []
        [ CoreHtml.node "style" [] [ Html.text (Css.compile [ css ] |> .css) ]
        , Html.nav [ class [ NavBar ] ] <|
            List.map viewLink sections
        , Html.main_ [ class [ Sections ] ] <|
            List.map viewSection sections
        ]


viewLink : Section -> Html Msg
viewLink section =
    Html.a
        [ class [ SectionLink ]
        , Attrs.href <| getSectionIdentifier section
        ]
        [ Html.text <| getSectionName section ]


viewSection : Section -> Html Msg
viewSection section =
    Html.section
        [ Attrs.id <| getSectionId section
        , class [ SectionSection ]
        ]
        [ Html.text <| getSectionName section ]


getSectionIdentifier : Section -> String
getSectionIdentifier section =
    "#" ++ getSectionId section


getSectionId : Section -> String
getSectionId section =
    case section of
        Home ->
            "home"

        About ->
            "about"

        Speakers ->
            "speakers"

        Location ->
            "location"

        Tickets ->
            "tickets"


getSectionName : Section -> String
getSectionName =
    toString



---- STYLES ----


namespace : String
namespace =
    "npvConference"


type CssClasses
    = NavBar
    | SectionLink
    | SectionSection
    | Sections


rem : Float -> Css.Px
rem =
    Css.px << (*) 14


navBarHeight : Css.Px
navBarHeight =
    rem 3


css : Css.Stylesheet
css =
    (Css.stylesheet << Css.Namespace.namespace namespace)
        [ Css.class NavBar
            [ Css.displayFlex
            , Css.height navBarHeight
            , Css.alignItems Css.center
            , Css.position Css.fixed
            ]
        , Css.class Sections
            []
        , Css.class SectionLink
            [ Css.margin2 Css.zero (rem 1)
            ]
        , Css.class SectionSection
            [ Css.height (rem 12)
            , Css.paddingTop navBarHeight
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
