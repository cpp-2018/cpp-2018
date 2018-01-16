module Main exposing (main)

import Accessibility as Html exposing (Html)
import Css
import Html as CoreHtml
import Html.Attributes as Attrs
import Html.Events as Events
import Ports
import Regex exposing (Regex, regex)
import Style exposing (class)
import Svg exposing (Svg, svg)
import Svg.Attributes


---- MODEL ----


type Visibility
    = Visible
    | Invisible


type alias Model =
    { active : Section
    , menu : Visibility
    , newsletterModal : Visibility
    }


init : ( Model, Cmd Msg )
init =
    ( { active = About
      , menu = Invisible
      , newsletterModal = Invisible
      }
    , allSections
        |> List.reverse
        |> List.map getSectionHash
        |> Ports.setupScrollSpy
    )



---- UPDATE ----


type Msg
    = HashChanged String
    | ToggleMenu
    | CloseMenu
    | ToggleModal
    | CloseModal


getSectionFromHash : String -> Result String Section
getSectionFromHash section =
    case section of
        "#about" ->
            Ok About

        "#speakers" ->
            Ok Speakers

        "#location" ->
            Ok Location

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
                        |> Result.withDefault About
              }
            , Cmd.none
            )

        ToggleMenu ->
            ( { model | menu = toggleVisibility model.menu }, Cmd.none )

        CloseMenu ->
            ( { model | menu = Invisible }, Cmd.none )

        ToggleModal ->
            ( { model
                | newsletterModal = toggleVisibility model.newsletterModal
              }
            , Cmd.none
            )

        CloseModal ->
            ( { model | newsletterModal = Invisible }, Cmd.none )



---- HELPERS ----


toggleVisibility : Visibility -> Visibility
toggleVisibility visibility =
    case visibility of
        Visible ->
            Invisible

        Invisible ->
            Visible



---- VIEW ----


type Section
    = About
    | Speakers
    | Location
    | Tickets
    | Contact


allSections : List Section
allSections =
    [ About
    , Speakers
    , Location
    , Tickets
    , Contact
    ]


navbarSections : List Section
navbarSections =
    [ About
    , Speakers
    , Location
    , Contact
    ]


type alias Speaker =
    { name : String
    , titles : List String
    }


speakers : List Speaker
speakers =
    [ Speaker
        "Alicia Danforth"
        [ "PhD" ]
    , Speaker
        "Charles Grob"
        [ "MD" ]
    , Speaker
        "Rosalind Watts"
        [ "DClinPsy" ]
    , Speaker
        "Alexander Lebedev"
        [ "MD PhD" ]

    -- , Speaker
    --     "Jordi Riba"
    --     "Head of Reaserch Group Human Neuropsychopharmacology"
    --     "Barcelona, Spain"
    -- , Speaker
    --     "Kim Kuypers"
    --     "Assistant Professor - Section Psychopharmacology, Neuropsychology & Psychopharmacology, Departments, Faculty of Psychology and Neuroscience"
    --     "Maastricht, Netherlands"
    -- , Speaker
    --     "Franz X Vollenweider"
    --     "Co-Director Center for Psychiatric Research Director Neuropsychopharmacology and Brain Imaging"
    --     "Zürich, Switzerland"
    -- , Speaker
    --     "Elizabeth Nielson"
    --     "Psychologist at Center for Optimal Living Center for Optimal Living"
    --     "Greater New York area, USA"
    -- , Speaker
    --     "Adele Robinson"
    --     "Associate Professor, Psychology"
    --     "Sudbury, USA"
    -- , Speaker
    --     "Anne Wagner"
    --     "Professor Emerita Modern and Contemporary Art"
    --     "San Francisco, USA"
    -- , Speaker
    --     "Déborah Gonzàlez"
    --     ""
    --     "Barcelona, Spain"
    -- , Speaker
    --     "Anja Loizaga-Velder"
    --     ""
    --     ""
    -- , Speaker
    --     "Gabrielle Agin-Liebes"
    --     ""
    --     ""
    ]


injectCss : Html msg
injectCss =
    CoreHtml.node "style"
        []
        [ Html.text (Css.compile [ Style.css ] |> .css)
        ]


ticketUrl : String
ticketUrl =
    "/tickets"


viewTicketLink : Html Msg
viewTicketLink =
    Html.button
        [ class [ Style.TicketLink ]
        , Events.onClick ToggleModal
        ]
        [ Html.text "Get tickets"
        ]


viewHamburgerMenu : Html msg
viewHamburgerMenu =
    svg
        [ Svg.Attributes.width "32"
        , Svg.Attributes.height "32"
        , Svg.Attributes.viewBox "0 0 32 32"
        ]
        [ Svg.path
            [ Svg.Attributes.fill "currentColor"
            , Svg.Attributes.d "M4,10h24c1.104,0,2-0.896,2-2s-0.896-2-2-2H4C2.896,6,2,6.896,2,8S2.896,10,4,10z M28,14H4c-1.104,0-2,0.896-2,2  s0.896,2,2,2h24c1.104,0,2-0.896,2-2S29.104,14,28,14z M28,22H4c-1.104,0-2,0.896-2,2s0.896,2,2,2h24c1.104,0,2-0.896,2-2  S29.104,22,28,22z"
            ]
            []
        ]


viewHeader : Section -> Visibility -> Html Msg
viewHeader active menu =
    Html.header [ class [ Style.Header ] ]
        [ Html.div [ class [ Style.HeaderGradient ] ] []
        , Html.div [ class [ Style.HeaderContent ] ]
            [ Html.nav [ class [ Style.NavBar, Style.BigNav ] ] <|
                List.map (viewSectionLink active) navbarSections
            , viewTicketLink
            , Html.div [ class [ Style.SmallNav ] ]
                [ Html.button
                    [ class [ Style.HamburgerMenuButton ]
                    , Events.onClick ToggleMenu
                    ]
                    [ viewHamburgerMenu
                    ]
                , case menu of
                    Visible ->
                        Html.nav [ class [ Style.HamburgerMenuMenu ] ] <|
                            List.map (viewSectionLink active) navbarSections

                    Invisible ->
                        Html.text ""
                ]
            ]
        ]


viewMailChimp : Html Msg
viewMailChimp =
    Html.div
        [ class [ Style.MailChimp ]
        , Attrs.id "mc_embed_signup"
        ]
        [ Html.form
            [ Attrs.action "https://psykedeliskvetenskap.us13.list-manage.com/subscribe/post?u=3a55f04b8de66cab9b612bdcf&amp;id=a1ac2bad9a"
            , Attrs.method "post"
            , Attrs.id "mc-embedded-subscribe-form"
            , Attrs.name "mc-embedded-subscribe-form"
            , Attrs.class "validate"
            , Attrs.target "_blank"
            , Attrs.novalidate True
            ]
            [ Html.div [ Attrs.id "mc_embed_signup_scroll" ]
                [ Html.label
                    [ Attrs.for "mce-EMAIL" ]
                    [ Html.text "Subscribe to our mailing list for news about tickets and speakers" ]
                , CoreHtml.input
                    [ Attrs.type_ "email"
                    , Attrs.value ""
                    , Attrs.name "EMAIL"
                    , Attrs.class "email"
                    , Attrs.id "mce-EMAIL"
                    , Attrs.placeholder "Email address"
                    , Attrs.required True
                    ]
                    []
                , Html.div
                    [ Attrs.style
                        [ ( "position", "absolute" )
                        , ( "left", "-5000px" )
                        ]
                    , Attrs.attribute "aria-hidden" "true"
                    ]
                    [ CoreHtml.input
                        [ Attrs.type_ "text"
                        , Attrs.name "b_3a55f04b8de66cab9b612bdcf_a1ac2bad9a"
                        , Attrs.tabindex -1
                        , Attrs.value ""
                        ]
                        []
                    ]
                , Html.div
                    [ Attrs.class "clear" ]
                    [ CoreHtml.input
                        [ Attrs.type_ "submit"
                        , Attrs.value "Subscribe"
                        , Attrs.name "subscribe"
                        , Attrs.id "mc-embedded-subscribe"
                        , Attrs.class "button"
                        , Attrs.style [ ( "margin", "0 0.25em" ) ]
                        , Events.onClick CloseModal
                        ]
                        []
                    ]
                ]
            ]
        ]


viewNewsletterModal : Visibility -> Html Msg
viewNewsletterModal visibility =
    case visibility of
        Visible ->
            Html.div [ class [ Style.ModalOverlay ] ]
                [ Html.div
                    [ class [ Style.Modal ] ]
                    [ viewMailChimp
                    , Html.button
                        [ class [ Style.ModalClose ]
                        , Events.onClick CloseModal
                        ]
                        [ Html.text "X" ]
                    ]
                ]

        Invisible ->
            Html.text ""


view : Model -> Html Msg
view model =
    Html.div []
        [ injectCss
        , viewHeader model.active model.menu
        , Html.main_ [ class [ Style.Sections ] ] <|
            List.map viewSection allSections
        , viewNewsletterModal model.newsletterModal
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
    CoreHtml.a
        [ class classes
        , Attrs.href <| getSectionHash section
        , Events.onClick CloseMenu
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
        , Html.div [ class [ Style.HomeLogoWrapper ] ]
            [ Html.video
                [ Attrs.src "/docs/assets/background.mp4"
                , Attrs.autoplay True
                , Attrs.loop True
                , Attrs.preload "auto"
                , Attrs.attribute "muted" "true"
                , Attrs.attribute "playsinline" "true"
                , class [ Style.HomeLogoVideo, Style.HomeLogo ]
                ]
                []
            , Html.decorativeImg
                [ class [ Style.HomeLogo ]
                , Attrs.src "/docs/assets/logomask.svg"
                ]
            ]
        , viewHomeText "13th to 14th" "of October"
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
        , Html.p [] [ Html.text "Hello, and the warmest of welcomes to this digital home of ours! " ]
        , Html.p [] [ Html.text "“Colloquium” is a latin term with three interpretations, the most common of which refers to an academic seminar. The Colloquium on Psychedelic Psychiatry 2018 will be a high quality, 2-day international academic seminar on psychedelic science, with a special focus on the use of psychedelics in psychiatry. " ]
        , Html.p [] [ Html.text "Colloquium can however also refer to a “musical piece celebrating birth or distribution of good news”, (a hymn in other words). This, we thought, would be an apt metaphor for the current state of affairs of psychedelic research, with groundbreaking projects and promising results sprouting globally. The recent findings open the doors to a new era of psychiatry, offering new possibilities to understand the pathologies behind mental problems and address them at their roots." ]
        , Html.p [] [ Html.text "Last but not least, colloquium is also a legal term used to describe the part of a defamation complaint in which the plaintiff averts slanderous remarks related to him or her. As such we would like to regard this conference as a symbolic colloquium against the derogatory campaigns carried out towards the psychedelic society and its scientists. We aim to help the current research shed much needed light and thereby break the stigma bestowed upon this important field of subject and the promises it holds both in regard for medicine and science in general. " ]
        , Html.p [] [ Html.text "It’s with great honour and anticipation that we hereby extend an invitation to you alongside the rest of the psychedelic science community to gather in Sweden this coming October!" ]
        ]


viewAbout : Html msg
viewAbout =
    Html.div [ class [ Style.About ] ]
        [ Html.decorativeImg
            [ class [ Style.CPPLogo ]
            , Attrs.src "/docs/assets/cpp18_logo.svg"
            ]
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
    "/docs/assets/speakers/" ++ normalized ++ ".jpg"


viewSpeaker : Speaker -> Html msg
viewSpeaker speaker =
    Html.div [ class [ Style.Speaker ] ]
        [ Html.decorativeImg
            [ Attrs.src <| getImageUrl speaker.name
            , class [ Style.SpeakerImage ]
            ]
        , Html.h1 [ class [ Style.SpeakerName ] ]
            [ Html.text <| speaker.name ++ ", " ++ String.join " " speaker.titles
            ]
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
        , Html.h1
            [ class [ Style.MoreInfoSoon ] ]
            [ Html.text "More coming soon" ]
        ]


viewLocation : Html msg
viewLocation =
    Html.div [ class [ Style.Location ] ]
        [ Html.h1
            [ class [ Style.LocationMoreInfoSoon ] ]
            [ Html.text "CPP2018 will take place in central Stockholm. More information coming soon." ]
        ]


viewUnderline : Html msg
viewUnderline =
    Html.div [ class [ Style.Underline ] ] []


viewTickets : Html Msg
viewTickets =
    Html.div
        [ class [ Style.Tickets ] ]
        [ Html.button
            [ class [ Style.TicketsTitle ]
            , Events.onClick ToggleModal
            ]
            [ Html.text "Get your tickets now" ]
        , viewUnderline
        ]


viewContactText : String -> Html msg -> Html msg
viewContactText title content =
    Html.div [ class [ Style.ContactText ] ]
        [ Html.h1 [ class [ Style.ContactTitle ] ] [ Html.text title ]
        , Html.div [ class [ Style.ContactTextContent ] ] [ content ]
        ]


viewContactParagraph : String -> Html msg
viewContactParagraph paragraph =
    Html.p
        [ class [ Style.ContactParagraph ] ]
        [ Html.text paragraph ]


viewContact : Html Msg
viewContact =
    Html.div
        [ class [ Style.Contact ] ]
        [ Html.div [ class [ Style.ContactLeft ] ]
            [ Html.decorativeImg
                [ class [ Style.ContactCPPLogo ]
                , Attrs.src "/docs/assets/cpp18_logo_white_green.svg"
                ]
            , viewContactText
                "*Colloquium"
                (Html.div [ class [ Style.ContactParagraphs ] ] <|
                    List.map
                        viewContactParagraph
                        [ "An academic seminar usually led by a different lecturer and on a different topic at each meeting or similarly to a tutorial led by students as is the case in Norway."
                        , "The Parliament of Scotland, called a \"colloquium\" in Latin records \"Any musical piece celebrating birth or distribution of good news, a hymn (antonyms: requiem, coronach)\""
                        , "The part of a complaint for defamation in which the plaintiff avers that the defamatory remarks related to him or her"
                        ]
                )
            , viewContactText
                "Contact"
                (Html.div []
                    [ Html.div [ class [ Style.ContactContactInfo ] ]
                        [ Html.div [] [ Html.text "FILIP BROMBERG - Project manager" ]
                        , Html.div [] [ Html.text "filip@npv.se" ]
                        ]
                    , Html.div [ class [ Style.ContactContactInfo ] ]
                        [ Html.div [] [ Html.text "Sponsor inquiries" ]
                        , Html.div [] [ Html.text "patreon@npv.se" ]
                        ]
                    ]
                )
            ]
        , Html.div
            [ class [ Style.AboutCircle ] ]
            [ Html.decorativeImg
                [ class [ Style.AboutNPVLogo ]
                , Attrs.src "/docs/assets/npv_logo.svg"
                ]
            , Html.p [] [ Html.text "Föreningens syfte är att främja ett vetenskapligt förhållningssätt till psykedeliska substanser och öka möjligheterna för forskare att undersöka verkningsmekanismer, risker och potentiella kliniska tillämpningar" ]
            ]
        , viewMailChimp
        ]


viewSection : Section -> Html Msg
viewSection section =
    let
        ( sectionClasses, contentClasses, content ) =
            case section of
                About ->
                    ( []
                    , []
                    , Html.div []
                        [ viewHome
                        , viewAbout
                        ]
                    )

                Speakers ->
                    ( [ Style.DarkBackground ], [], viewSpeakers )

                Location ->
                    ( [], [], viewLocation )

                Tickets ->
                    ( [], [], viewTickets )

                Contact ->
                    ( [ Style.ContactSection ], [ Style.ContactContent ], viewContact )
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
        About ->
            "about"

        Speakers ->
            "speakers"

        Location ->
            "location"

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
