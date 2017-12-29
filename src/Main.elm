module Main exposing (main)

import Accessibility as Html exposing (Html)
import Css
import Html as CoreHtml
import Html.Attributes as Attrs
import Ports
import Style exposing (class)


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
        [ class
            [ Style.SectionLink
            , Style.TicketLink
            , Style.HeaderChild
            ]
        , Attrs.href "/tickets"
        ]
        [ Html.text "Get tickets"
        ]


viewHeader : Section -> Html Msg
viewHeader active =
    Html.header [ class [ Style.Header ] ]
        [ Html.div [ class [ Style.HeaderGradient ] ] []
        , Html.div [ class [ Style.HeaderContent ] ]
            [ Html.nav [ class [ Style.NavBar, Style.HeaderChild ] ] <|
                List.map (viewSectionLink active) sections
            , viewTicketLink
            ]
        ]


view : Model -> Html Msg
view model =
    Html.div []
        [ injectCss
        , viewHeader model.active
        , Html.main_ [ class [ Style.Sections ] ] <|
            List.map viewSection sections
        ]


viewSectionLink : Section -> Section -> Html Msg
viewSectionLink active section =
    let
        classes =
            Style.SectionLink
                :: (if section == active then
                        [ Style.ActiveSectionLink ]
                    else
                        []
                   )
    in
    Html.a
        [ class classes
        , Attrs.href <| getSectionHash section
        ]
        [ Html.text <| getSectionName section ]


viewHomeText : String -> String -> Html msg
viewHomeText topText bottomText =
    Html.div [ class [ Style.HomeText ] ]
        [ Html.div [] [ Html.text topText ]
        , Html.div [] [ Html.text bottomText ]
        , Html.div [ class [ Style.HomeTextBorder ] ] []
        ]


viewHome : Html msg
viewHome =
    Html.div [ class [ Style.Home ] ]
        [ viewHomeText "Stockholm" "2018"
        , viewHomeText "13th to 14th" "of October"
        ]


viewAboutTitle : Html msg
viewAboutTitle =
    Html.div [ class [ Style.AboutTitle ] ]
        [ Html.div
            [ class [ Style.AboutTitleLeft ] ]
            [ Html.text "'18" ]
        , Html.div [ class [ Style.AboutTitleRight ] ]
            [ Html.div
                [ class [ Style.AboutTitleRightTop ] ]
                [ Html.text "Colloquium on" ]
            , Html.div
                [ class [ Style.AboutTitleRightBottom ] ]
                [ Html.text "Psychedelic Psychiatry" ]
            ]
        ]


viewAboutIntroText : Html msg
viewAboutIntroText =
    Html.div [ class [ Style.AboutIntroText ] ]
        [ Html.text "A high quality, 2-day international academic seminar on psychedelic science, with a special focus on the use of psychedelics in psychiatry"
        ]


viewAboutText : Html msg
viewAboutText =
    Html.div [ class [ Style.AboutText ] ]
        [ Html.h4 [ class [ Style.AboutTextTitle ] ] [ Html.text "Stockholm, December 20th, 2017." ]
        , Html.p [] [ Html.text "Before venturing forth into the tripartite reasoning behind choosing such a quaint and “whatchamacallit” name for this scientific conference, please allow us to first bid you a very warm welcome to this digital home of ours!" ]
        , Html.p [] [ Html.text "Now, one definition of the word colloquium is that of an academic seminar. Which of course fits the bill perfectly. Psychedelic Colloquium 2018 will be a high quality, 2-day international academic seminar on psychedelic science, with a special focus on the use of psychedelics in psychiatry.  We hope to see you there." ]
        , Html.p [] [ Html.text "Interestingly enough colloquium can however also mean a “musical piece celebrating birth or distribution of good news”. A hymn in other words.  And upon learning that--while hearing a faint fanfare from somewhere at the back of our minds-- we thought: “Couldn’t that be an apt metaphor for the current state of affairs of psychedelic research, with its plethora of promising results coming in from one study more groundbreaking than the next; each offering a hopeful piece to the otherwise somewhat gloomy jigsaw puzzle that is our world and its future”. Wouldn’t you agree?" ]
        , Html.p [] [ Html.text "Last but not least colloquium is also a legal term used to describe the part of a defamation complaint in which the plaintiff avers that the defamatory remarks related to him or her. As such we would like to regard this conference as a symbolic colloquium on the behalf of psychedelic science against the defamation campaigns carried out against it, starting in the mid 60’s and still continuing in our present day and age. May the current research renaissance shed much needed light and help disperse the lies woven around these important substances and their therapeutic as well as medicinal potential." ]
        , Html.p [] [ Html.text "It’s with great honour and anticipation that we hereby invite the rest of the psychedelic science community to gather in Sweden this coming October." ]
        ]


viewAbout : Html msg
viewAbout =
    Html.div [ class [ Style.About ] ]
        [ viewAboutTitle
        , viewAboutIntroText
        , viewAboutText
        ]


viewSection : Section -> Html Msg
viewSection section =
    Html.section
        [ Attrs.id <| getSectionId section
        , class [ Style.SectionSection ]
        ]
        [ case section of
            Home ->
                viewHome

            About ->
                viewAbout

            Speakers ->
                Html.text <| getSectionName section

            Program ->
                Html.text <| getSectionName section

            Location ->
                Html.text <| getSectionName section

            Contact ->
                Html.text <| getSectionName section
        ]


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
