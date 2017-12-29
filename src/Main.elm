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


viewHeader : Section -> Html Msg
viewHeader active =
    Html.header [ class [ Header ] ]
        [ Html.div [ class [ HeaderGradient ] ] []
        , Html.div [ class [ HeaderContent ] ] []
        ]


view : Model -> Html Msg
view model =
    Html.div []
        [ injectCss
        , viewHeader model.active
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
    = Header
    | HeaderGradient
    | HeaderContent
    | SectionLink
    | ActiveSectionLink
    | SectionSection
    | Sections


css : Css.Stylesheet
css =
    let
        rem : Float -> Css.Px
        rem =
            Css.px << (*) 14

        navBarHeight : Css.Px
        navBarHeight =
            rem 5

        colors =
            { primary =
                { light = Css.hex "9469a9"
                , dark = Css.hex "9469a9"
                }
            , secondary =
                { light = Css.hex "f8f8f8"
                , dark = Css.hex "#808184"
                }
            , accent = Css.hex "#6affc2"
            , background = Css.hex "#fff7f5"
            , white = Css.hex "#ffffff"
            , blue = Css.hex "#0000ff"
            , orange = Css.hex "#ff9c8a"
            }

        gradientBackground =
            Css.backgroundImage <|
                Css.linearGradient2
                    Css.toRight
                    (Css.stop colors.blue)
                    (Css.stop colors.orange)
                    []
    in
    (Css.stylesheet << Css.Namespace.namespace namespace)
        [ Css.everything
            [ Css.boxSizing Css.borderBox
            ]
        , Css.Elements.body
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
        , Css.class Header
            [ Css.height navBarHeight
            , Css.displayFlex
            , Css.flexDirection Css.column
            , Css.position Css.fixed
            ]
        , Css.class HeaderContent
            [ Css.displayFlex
            , Css.justifyContent Css.spaceAround
            , Css.width (Css.vw 100)
            , Css.backgroundColor colors.background
            , Css.flexGrow (Css.num 1)
            ]
        , Css.class HeaderGradient
            [ Css.height (rem 0.5)
            , gradientBackground
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
        , Css.class HeaderChild
            [ Css.displayFlex
            , Css.alignItems Css.center
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
