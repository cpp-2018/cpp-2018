module Main exposing (main)

import Accessibility as Html exposing (Html)
import Css
import Html as CoreHtml
import Html.Attributes as Attrs
import Ports
import Style exposing (CssClasses(..), class)


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
        |> Ports.setupScrollSpy
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

        "#program" ->
            Ok Program

        "#location" ->
            Ok Location

        "#contact" ->
            Ok Contact

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


type Section
    = Home
    | About
    | Speakers
    | Program
    | Location
    | Contact


sections : List Section
sections =
    [ Home
    , About
    , Speakers
    , Program
    , Location
    , Contact
    ]


injectCss : Html msg
injectCss =
    CoreHtml.node "style"
        []
        [ Html.text (Css.compile [ Style.css ] |> .css)
        ]


viewTicketLink : Html msg
viewTicketLink =
    Html.a
        [ class [ SectionLink, TicketLink, HeaderChild ]
        , Attrs.href "/tickets"
        ]
        [ Html.text "Get tickets"
        ]


viewHeader : Section -> Html Msg
viewHeader active =
    Html.header [ class [ Header ] ]
        [ Html.div [ class [ HeaderGradient ] ] []
        , Html.div [ class [ HeaderContent ] ]
            [ Html.nav [ class [ NavBar, HeaderChild ] ] <|
                List.map (viewSectionLink active) sections
            , viewTicketLink
            ]
        ]


view : Model -> Html Msg
view model =
    Html.div []
        [ injectCss
        , viewHeader model.active
        , Html.main_ [ class [ Sections ] ] <|
            List.map viewSection sections
        ]


viewSectionLink : Section -> Section -> Html Msg
viewSectionLink active section =
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

        Program ->
            "program"

        Location ->
            "location"

        Contact ->
            "contact"


getSectionName : Section -> String
getSectionName =
    toString



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Ports.activeHash HashChanged
