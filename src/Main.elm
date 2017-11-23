port module Main exposing (main)

import Accessibility as Html exposing (Html)
import Css
import Css.Elements
import Css.Namespace
import Html as CoreHtml
import Html.Attributes as Attrs
import Html.CssHelpers


---- MODEL ----


type alias Model =
    { active : Section
    }


init : ( Model, Cmd Msg )
init =
    ( { active = Home
      }
    , sections
        |> List.reverse
        |> List.map getSectionHash
        |> setupScrollSpy
    )



---- UPDATE ----


type Msg
    = HashChanged String


getSectionFromHash : String -> Result String Section
getSectionFromHash section =
    case section of
        "#home" ->
            Ok Home

        "#about" ->
            Ok About

        "#speakers" ->
            Ok Speakers

        "#location" ->
            Ok Location

        "#tickets" ->
            Ok Tickets

        _ ->
            Err "Invalid hash"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HashChanged location ->
            ( { model
                | active =
                    location
                        |> getSectionFromHash
                        |> Result.withDefault Home
              }
            , Cmd.none
            )



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


injectCss : Html msg
injectCss =
    CoreHtml.node "style"
        []
        [ Html.text (Css.compile [ css ] |> .css)
        ]


view : Model -> Html Msg
view model =
    Html.div []
        [ injectCss
        , Html.nav [ class [ NavBar ] ] <|
            List.map (viewLink model.active) sections
        , Html.main_ [ class [ Sections ] ] <|
            List.map viewSection sections
        ]


viewLink : Section -> Section -> Html Msg
viewLink active section =
    let
        classes =
            SectionLink
                :: (if section == active then
                        [ ActiveSectionLink ]
                    else
                        []
                   )
    in
    Html.a
        [ class classes
        , Attrs.href <| getSectionHash section
        ]
        [ Html.text <| getSectionName section ]


viewSection : Section -> Html Msg
viewSection section =
    Html.section
        [ Attrs.id <| getSectionId section
        , class [ SectionSection ]
        ]
        [ Html.text <| getSectionName section ]


getSectionHash : Section -> String
getSectionHash section =
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
    | ActiveSectionLink
    | SectionSection
    | Sections


rem : Float -> Css.Px
rem =
    Css.px << (*) 14


navBarHeight : Css.Px
navBarHeight =
    rem 3


colors :
    { primary : { dark : Css.Color, light : Css.Color }
    , secondary : { dark : Css.Color, light : Css.Color }
    }
colors =
    { primary =
        { light = Css.hex "9469a9"
        , dark = Css.hex "9469a9"
        }
    , secondary =
        { light = Css.hex "f8f8f8"
        , dark = Css.hex "e7e7e7"
        }
    }


css : Css.Stylesheet
css =
    (Css.stylesheet << Css.Namespace.namespace namespace)
        [ Css.Elements.body
            [ Css.margin Css.zero
            , Css.fontFamily Css.sansSerif
            ]
        , Css.Elements.a
            [ Css.color colors.primary.light
            , Css.textDecoration Css.none
            , Css.hover
                [ Css.color colors.primary.dark
                ]
            ]
        , Css.class NavBar
            [ Css.displayFlex
            , Css.height navBarHeight
            , Css.width (Css.vw 100)
            , Css.position Css.fixed
            , Css.borderBottom3 (Css.px 1) Css.solid colors.secondary.dark
            , Css.backgroundColor colors.secondary.light
            ]
        , Css.class Sections
            []
        , Css.class SectionLink
            [ Css.padding2 Css.zero (rem 1)
            , Css.displayFlex
            , Css.alignItems Css.center
            , Css.hover
                [ Css.backgroundColor colors.secondary.dark
                ]
            ]
        , Css.class ActiveSectionLink
            [ Css.backgroundColor colors.secondary.dark
            ]
        , Css.class SectionSection
            [ Css.minHeight (Css.vh 100)
            , Css.paddingTop navBarHeight
            , Css.nthChild "odd"
                [ Css.backgroundColor colors.secondary.light
                ]
            , Css.nthChild "even"
                [ Css.backgroundColor colors.secondary.dark
                ]
            ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }



---- PORTS ----


port activeHash : (String -> msg) -> Sub msg


port setupScrollSpy : List String -> Cmd msg



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    activeHash HashChanged
