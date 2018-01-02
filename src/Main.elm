module Main exposing (main)

import Accessibility as Html exposing (Html)
import Css
import Html as CoreHtml
import Html.Attributes as Attrs
import Ports
import Regex exposing (Regex, regex)
import Style exposing (class)


---- MODEL ----


type alias Model =
    { active : Section
    }


init : ( Model, Cmd Msg )
init =
    ( { active = Home
      }
    , allSections
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

        "#tickets" ->
            Ok Tickets

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
    | Tickets
    | Contact


allSections : List Section
allSections =
    [ Home
    , About
    , Speakers
    , Tickets
    , Contact
    ]


navbarSections : List Section
navbarSections =
    [ Home
    , About
    , Speakers
    , Contact
    ]


type alias Speaker =
    { name : String
    , description : String
    , location : String
    }


speakers : List Speaker
speakers =
    [ Speaker
        "Jordi Riba"
        "Head of Reaserch Group Human Neuropsychopharmacology"
        "Barcelona, Spain"
    , Speaker
        "Alicia Dansworth"
        "Clinical Psychologist - Private Practise Institute of Transpersonal Psychology"
        "San Francisco, USA"
    , Speaker
        "Charles Grob"
        "Director of Division of Child and Adolescent Psychiatry"
        "Los Angeles, USA"
    , Speaker
        "Kim Kuypers"
        "Assistant Professor - Section Psychopharmacology, Neuropsychology & Psychopharmacology, Departments, Faculty of Psychology and Neuroscience"
        "Maastricht, Netherlands"
    , Speaker
        "Franz X Vollenweider"
        "Co-Director Center for Psychiatric Research Director Neuropsychopharmacology and Brain Imaging"
        "Zürich, Switzerland"
    , Speaker
        "Elizabeth Nielson"
        "Psychologist at Center for Optimal Living Center for Optimal Living"
        "Greater New York area, USA"
    , Speaker
        "Adele Robinson"
        "Associate Professor, Psychology"
        "Sudbury, USA"
    , Speaker
        "Anne Wagner"
        "Professor Emerita Modern and Contemporary Art"
        "San Francisco, USA"
    , Speaker
        "Déborah Gonzàlez"
        ""
        "Barcelona, Spain"
    , Speaker
        "Anja Loizaga-Velder"
        ""
        ""
    , Speaker
        "Gabrielle Agin-Liebes"
        ""
        ""
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
                List.map (viewSectionLink active) navbarSections
            , viewTicketLink
            ]
        ]


view : Model -> Html Msg
view model =
    Html.div []
        [ injectCss
        , viewHeader model.active
        , Html.main_ [ class [ Style.Sections ] ] <|
            List.map viewSection allSections
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
        , viewUnderline
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


viewSpeakersTitle : Html msg
viewSpeakersTitle =
    Html.div [ class [ Style.SpeakersTitle ] ]
        [ Html.h2
            [ class [ Style.SpeakersTitleTop ] ]
            [ Html.text "Preliminary bookings:" ]
        , Html.h1
            [ class [ Style.SpeakersTitleBottom ] ]
            [ Html.text "Speakers" ]
        ]


whitespace : Regex
whitespace =
    regex "\\s+"


getImageUrl : String -> String
getImageUrl name =
    let
        normalized =
            name
                |> String.toLower
                |> Regex.replace Regex.All whitespace (\_ -> "-")
    in
    "/assets/speakers/" ++ normalized ++ ".jpg"


viewSpeaker : Speaker -> Html msg
viewSpeaker speaker =
    Html.div [ class [ Style.Speaker ] ]
        [ Html.decorativeImg
            [ Attrs.src <| getImageUrl speaker.name
            , class [ Style.SpeakerImage ]
            ]
        , Html.h1 [ class [ Style.SpeakerName ] ] [ Html.text speaker.name ]
        , Html.div [ class [ Style.SpeakerText ] ] [ Html.text speaker.description ]
        , Html.div [ class [ Style.SpeakerText ] ] [ Html.text speaker.location ]
        ]


viewSpeakersSpeakers : Html msg
viewSpeakersSpeakers =
    Html.div [ class [ Style.SpeakersSpeakers ] ] <|
        List.map viewSpeaker speakers


viewSpeakers : Html msg
viewSpeakers =
    Html.div [ class [ Style.Speakers ] ]
        [ viewSpeakersTitle
        , viewSpeakersSpeakers
        ]


viewUnderline : Html msg
viewUnderline =
    Html.div [ class [ Style.Underline ] ] []


viewTickets : Html msg
viewTickets =
    Html.div
        [ class [ Style.Tickets ] ]
        [ Html.a
            [ class [ Style.TicketsTitle ] ]
            [ Html.text "Get your tickets now" ]
        , viewUnderline
        ]


viewContact : Html msg
viewContact =
    Html.div
        [ class [ Style.Contact ] ]
        []


viewSection : Section -> Html Msg
viewSection section =
    let
        ( sectionClasses, contentClasses, content ) =
            case section of
                Home ->
                    ( [], [], viewHome )

                About ->
                    ( [], [], viewAbout )

                Speakers ->
                    ( [ Style.DarkBackground ], [], viewSpeakers )

                Tickets ->
                    ( [], [], viewTickets )

                Contact ->
                    ( [ Style.ContactSection ], [], viewContact )
    in
    Html.section
        [ Attrs.id <| getSectionId section
        , class <| Style.SectionSection :: sectionClasses
        ]
        [ Html.div
            [ class <| Style.SectionContent :: contentClasses ]
            [ content ]
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

        Tickets ->
            "tickets"

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
