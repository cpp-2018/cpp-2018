module Main exposing (main)

import Accessibility as Html exposing (Html)
import Html as CoreHtml
import Html.Attributes as Attrs
import Html.Events as Events exposing (defaultOptions)
import Json.Decode as Decode
import Ports
import Regex exposing (Regex, regex)
import Speakers exposing (Speaker, speakers)
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
    , speakerInfoModal : Maybe Speaker
    }


init : ( Model, Cmd Msg )
init =
    ( { active = About
      , menu = Invisible
      , newsletterModal = Invisible
      , speakerInfoModal = Nothing
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
    | ModalClicked
    | SpeakerClicked Speaker


getSectionFromHash : String -> Result String Section
getSectionFromHash section =
    case section of
        "#about" ->
            Ok About

        "#speakers" ->
            Ok Speakers

        "#venue" ->
            Ok Venue

        "#tickets" ->
            Ok Tickets

        "#call-for-abstracts" ->
            Ok CallForAbstracts

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
            ( { model
                | newsletterModal = Invisible
                , speakerInfoModal = Nothing
              }
            , Cmd.none
            )

        SpeakerClicked speaker ->
            ( { model
                | speakerInfoModal = Just speaker
              }
            , Cmd.none
            )

        ModalClicked ->
            ( model, Cmd.none )



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
    | Venue
    | Tickets
    | Contact
    | CallForAbstracts


allSections : List Section
allSections =
    [ About
    , Speakers
    , Venue
    , Tickets
    , CallForAbstracts
    , Contact
    ]


navbarSections : List Section
navbarSections =
    [ About
    , Speakers
    , Venue
    , Tickets
    , CallForAbstracts
    , Contact
    ]


ticketUrl : String
ticketUrl =
    "https://secure.tickster.com/Intro.aspx?ERC=5PWCFFRV5EU58MW"


formUrl : String
formUrl =
    "https://docs.google.com/forms/d/e/1FAIpQLSdGQSaUq69_UCqxKhTZ_GxaNI2_2bcSrpG8oK0iRRJu_LBo5w/viewform"


viewTicketLink : Html Msg
viewTicketLink =
    Html.a
        [ class [ Style.TicketLink ]
        , Attrs.href ticketUrl
        , Attrs.target "_blank"
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


viewModal : Html Msg -> Html Msg
viewModal content =
    CoreHtml.div
        [ class [ Style.ModalOverlay ]
        , Events.onClick CloseModal
        ]
        [ CoreHtml.div
            [ class [ Style.Modal ]
            , Events.onWithOptions
                "click"
                { defaultOptions | stopPropagation = True }
                (Decode.succeed ModalClicked)
            ]
            [ content
            , Html.button
                [ class [ Style.ModalClose ]
                , Events.onClick CloseModal
                ]
                [ Html.text "X" ]
            ]
        ]


viewNewsletterModal : Visibility -> Html Msg
viewNewsletterModal visibility =
    case visibility of
        Visible ->
            viewModal viewMailChimp

        Invisible ->
            Html.text ""


viewSpeakerInfoModal : Maybe Speaker -> Html Msg
viewSpeakerInfoModal speaker =
    case speaker of
        Just speaker_ ->
            viewModal <|
                Html.div
                    [ class [ Style.SpeakerModal ] ]
                    [ Html.decorativeImg
                        [ Attrs.src speaker_.image
                        , class [ Style.SpeakerModalImage ]
                        ]
                    , Html.map never speaker_.bio
                    ]

        Nothing ->
            Html.text ""


view : Model -> Html Msg
view model =
    Html.div []
        [ viewHeader model.active model.menu
        , Html.main_ [ class [ Style.Sections ] ] <|
            List.map viewSection allSections
        , viewNewsletterModal model.newsletterModal
        , viewSpeakerInfoModal model.speakerInfoModal
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
                [ Attrs.src "/build/assets/background.mp4"
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
                , Attrs.src "/build/assets/logomask.svg"
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
        , Html.p [] [ Html.text "Hello, and the warmest of welcomes to this digital home of ours!" ]
        , Html.p [] [ Html.text "“Colloquium” is a latin term with three interpretations, the most common of which refers to an academic seminar. The Colloquium on Psychedelic Psychiatry 2018 will be a high quality, 2-day international academic seminar on psychedelic science, with a special focus on the use of psychedelics in psychiatry." ]
        , Html.p [] [ Html.text "Colloquium can however also refer to a musical piece celebrating birth or distribution of good news, (a hymn in other words). This, we thought, would be an apt metaphor for the current state of affairs of psychedelic research, with groundbreaking projects and promising results sprouting globally. The recent findings open the doors to a new era of psychiatry, offering new possibilities to understand the pathologies behind mental health problems and address them at their roots." ]
        , Html.p [] [ Html.text "Last but not least, colloquium is also a legal term used to describe the part of a defamation complaint in which the plaintiff averts slanderous remarks related to him or her. As such we would like to regard this conference as a symbolic colloquium against the derogatory campaigns which lead to the abandonment of a whole field of study in the 60's. We aim to help the current research shed much needed light upon this important field, breaking the stigma bestowed upon it and releasing the potential it holds both in regard for medicine and science in general." ]
        , Html.p [] [ Html.text "It's with great honour and anticipation that we hereby extend an invitation to you alongside the rest of the psychedelic science community to gather in Sweden this coming October!" ]
        ]


viewAbout : Html msg
viewAbout =
    Html.div [ class [ Style.About ] ]
        [ Html.decorativeImg
            [ class [ Style.CPPLogo ]
            , Attrs.src "/build/assets/cpp18_logo.svg"
            ]
        , viewAboutIntroText
        , viewAboutText
        ]


viewTitle : String -> Html msg
viewTitle title =
    Html.div [ class [ Style.Title ] ]
        [ Html.h1
            [ class [ Style.TitleText ] ]
            [ Html.text title ]
        ]


whitespace : Regex
whitespace =
    regex "\\s+"


viewSpeaker : Speaker -> Html Msg
viewSpeaker speaker =
    CoreHtml.div
        [ class
            [ Style.Speaker
            ]
        , Events.onClick <| SpeakerClicked speaker
        ]
        [ Html.decorativeImg
            [ Attrs.src speaker.image
            , class [ Style.SpeakerImage ]
            ]
        , Html.h1 [ class [ Style.SpeakerName ] ]
            [ Html.text speaker.name
            ]
        ]


viewSpeakersSpeakers : Html Msg
viewSpeakersSpeakers =
    Html.div [ class [ Style.SpeakersSpeakers ] ] <|
        List.map viewSpeaker speakers


viewSpeakers : Html Msg
viewSpeakers =
    Html.div []
        [ viewTitle "Speakers"
        , viewSpeakersSpeakers
        , Html.h1
            [ class [ Style.MoreInfoSoon ] ]
            [ Html.text "More coming soon" ]
        ]


viewVenue : Html msg
viewVenue =
    Html.div [ class [ Style.Venue ] ]
        [ Html.h1
            [ class [ Style.VenueMoreInfoSoon ] ]
            [ Html.text "The Venue" ]
        , Html.decorativeImg
            [ Attrs.src "/build/assets/elite-hotel.jpg"
            , class [ Style.VenueImage ]
            ]
        , Html.p []
            [ Html.text "Colloquium on Psychedelic Psychiatry 2018 will take place at Elite Hotel Marina Tower in Stockholm, a high-end hotel conveniently accessible by short boat or bus ride from central Stockholm. Hotel rooms will be available at a discount price for conference participants. Breakfast and lunch will be included in the ticket price, making the hotel an all-round solution for both formal lectures and informal networking. And yes, the spa is open late."
            ]
        , Html.p []
            [ Html.text "More information about the venue "
            , Html.a
                [ Attrs.href "https://www.elite.se/en/hotels/stockholm/hotel-marina-tower/"
                , Attrs.target "_blank"
                , class [ Style.VenueLink ]
                ]
                [ Html.text "here" ]
            , Html.text "."
            ]
        ]


viewCallForAbstracts : Html msg
viewCallForAbstracts =
    Html.div [ class [ Style.Venue ] ]
        [ Html.h1
            [ class [ Style.VenueMoreInfoSoon ] ]
            [ Html.text "Call for Abstracts" ]
        , Html.p []
            [ Html.text "We are now accepting abstracts and posters to be presented during the conference! The deadline to submit an abstract for the conference is April 30th, 2018. To find out more and to submit an abstract, click "
            , Html.a
                [ Attrs.href formUrl
                , Attrs.target "_blank"
                , class [ Style.VenueLink ]
                ]
                [ Html.text "here" ]
            , Html.text "."
            ]
        ]


viewUnderline : Html msg
viewUnderline =
    Html.div [ class [ Style.Underline ] ] []


viewTickets : Html Msg
viewTickets =
    Html.div
        [ class [ Style.Tickets ] ]
        [ viewTitle "Tickets"
        , Html.div []
            [ Html.p
                [ class [ Style.TicketsInfo ] ]
                [ Html.text """
                TICKETS INCLUDE: Conference pass and food (breakfast, lunch and afternoon refreshments). Please state any food preferences or allergies in the form provided with ticket sales.

                General Release ticket: 3600 SEK
                General Release Student: 2400 SEK
                Early Bird: 2600 SEK
                Early Bird student: 1600 SEK

                *Students will be required to provide proof of registration or enrolment letter of their current university.

                All members of ‘Nätverket för Psykedelisk Vetenskap’ are eligible for a 200 SEK discount on all tickets. To receive this discount please follow the instructions given in our latest newsletter.

                NOTE: Tickets can not be refunded. Re-sale can be done through Tickster Resale if the ticket is purchased with a Swedish bank account.""" ]
            , Html.div []
                [ Html.a
                    [ class [ Style.TicketsLink ]
                    , Attrs.href ticketUrl
                    , Attrs.target "_blank"
                    ]
                    [ Html.text "Get tickets now" ]
                ]
            ]
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


viewContactEmailAddress : String -> Html msg
viewContactEmailAddress emailAddress =
    Html.a
        [ Attrs.href <| "mailto:" ++ emailAddress
        , class [ Style.EmailAddress ]
        ]
        [ Html.text emailAddress ]


viewContact : Html Msg
viewContact =
    Html.div
        [ class [ Style.Contact ] ]
        [ Html.div [ class [ Style.ContactLeft ] ]
            [ Html.decorativeImg
                [ class [ Style.ContactCPPLogo ]
                , Attrs.src "/build/assets/cpp18_logo_white_green.svg"
                ]
            , viewContactText
                "Contact"
                (Html.div []
                    [ Html.p [] [ Html.text "Press enquiries: ", viewContactEmailAddress "press@cpp2018.se" ]
                    , Html.p [] [ Html.text "General enquiries: ", viewContactEmailAddress "info@cpp2018.se" ]
                    , Html.p [] [ Html.text "Ticketing enquiries: ", viewContactEmailAddress "tickets@cpp2018.se" ]
                    , Html.p [] [ Html.text "Abstract and poster submissions are accepted strictly through the ‘Call for Abstracts’ form." ]
                    ]
                )
            ]
        , Html.a
            [ class [ Style.AboutCircle ]
            , Attrs.href "http://www.psykedeliskvetenskap.org/about"
            , Attrs.target "_blank"
            ]
            [ Html.decorativeImg
                [ class [ Style.AboutNPVLogo ]
                , Attrs.src "/build/assets/npv_logo.svg"
                ]
            , Html.p [] [ Html.text "Nätverket för psykedelisk vetenskap (The Swedish Network for Psychedelic Science) is a nonprofit organization based in Stockholm that works to promote a scientific exploration of psychedelic substances." ]
            ]
        , viewMailChimp
        , Html.div [ class [ Style.SocialMediaIcons ] ]
            [ viewIconLink "facebook" "https://facebook.com/events/1934770476537921/"
            , viewIconLink "twitter" "https://twitter.com/cpp2018"
            ]
        ]


viewIconLink : String -> String -> Html msg
viewIconLink icon href =
    Html.a
        [ Attrs.target "_blank"
        , Attrs.href href
        ]
        [ Html.i [ Attrs.class <| "fa fa-2x fa-fw fa-" ++ icon ] [] ]


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

                Venue ->
                    ( [], [], viewVenue )

                Tickets ->
                    ( [ Style.DarkBackground ], [], viewTickets )

                CallForAbstracts ->
                    ( [], [], viewCallForAbstracts )

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

        Venue ->
            "venue"

        Tickets ->
            "tickets"

        CallForAbstracts ->
            "call-for-abstracts"

        Contact ->
            "contact"


getSectionName : Section -> String
getSectionName section =
    case section of
        About ->
            "About"

        Speakers ->
            "Speakers"

        Venue ->
            "Venue"

        Tickets ->
            "Tickets"

        CallForAbstracts ->
            "Call for Abstracts"

        Contact ->
            "Contact"



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
