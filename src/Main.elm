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
import Ui exposing (column, paragraph)


---- MODEL ----


type Visibility
    = Visible
    | Invisible


type ModalContent
    = SpeakerInfo Speaker
    | Competition


type alias Model =
    { active : Section
    , menu : Visibility
    , modal : Maybe ModalContent
    }


type alias Flags =
    { showCompetitionModal : Bool
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { active = About
      , menu = Invisible
      , modal =
            if flags.showCompetitionModal then
                Just Competition
            else
                Nothing
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

        "#side-events" ->
            Ok SideEvents

        "#tickets" ->
            Ok Tickets

        "#partners" ->
            Ok Partners

        "#call-for-abstracts" ->
            Ok CallForAbstracts

        "#contact" ->
            Ok Contact

        "#accommodation" ->
            Ok Accommodation

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

        CloseModal ->
            ( { model | modal = Nothing }
            , Cmd.none
            )

        SpeakerClicked speaker ->
            ( { model | modal = Just (SpeakerInfo speaker) }
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
    | Accommodation
    | SideEvents
    | Tickets
    | Contact
    | Partners
    | CallForAbstracts


allSections : List Section
allSections =
    [ About
    , Speakers
    , Venue
    , Accommodation
    , SideEvents
    , Tickets
    , Partners
    , CallForAbstracts
    , Contact
    ]


navbarSections : List Section
navbarSections =
    [ About
    , Speakers
    , Venue
    , Accommodation
    , SideEvents
    , Tickets
    , Partners
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


viewCompetition : Html Msg
viewCompetition =
    Html.div
        [ class [ Style.CompetitionModal ] ]
        [ Html.h1 [] [ Html.text "Stay in style at the conference!" ]
        , paragraph [ Html.text "Get your ticket before July 31st in order to be in the draw for a deluxe room at Elite Hotel Marina Tower during the conference! Summer discount tickets are available. The winner will be announced and contacted on August 1st." ]
        , viewTicketLink
        ]


viewModal : Maybe ModalContent -> Html Msg
viewModal content =
    case content of
        Nothing ->
            Html.text ""

        Just (SpeakerInfo speaker) ->
            viewModalContent <|
                Html.div
                    [ class [ Style.SpeakerModal ] ]
                    [ Html.decorativeImg
                        [ Attrs.src speaker.image
                        , class [ Style.SpeakerModalImage ]
                        ]
                    , Html.map never speaker.bio
                    ]

        Just Competition ->
            viewModalContent viewCompetition


viewModalContent : Html Msg -> Html Msg
viewModalContent content =
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


view : Model -> Html Msg
view model =
    Html.div []
        [ viewHeader model.active model.menu
        , Html.main_ [ class [ Style.Sections ] ] <|
            List.map viewSection allSections
        , viewModal model.modal
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


type TitleColor
    = Light
    | Dark


viewTitle : TitleColor -> String -> Html msg
viewTitle color title =
    let
        colorStyle =
            case color of
                Light ->
                    Style.LightTitle

                Dark ->
                    Style.DarkTitle
    in
    Html.div [ class [ Style.Title ] ]
        [ Html.h1
            [ class [ Style.TitleText, colorStyle ] ]
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
        [ viewTitle Light "Speakers"
        , viewSpeakersSpeakers
        , Html.h1
            [ class [ Style.MoreInfoSoon ] ]
            [ Html.text "More coming soon" ]
        ]


viewVenue : Html msg
viewVenue =
    Html.div [ class [ Style.Venue ] ]
        [ viewTitle Dark "The Venue"
        , Html.div [ class [ Style.VenueContent ] ]
            [ Html.div [ class [ Style.VenueText, Style.DarkText ] ]
                [ Html.p []
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
            , Html.div [ class [ Style.VenueImages ] ]
                [ Html.div [ class [ Style.VenueSmallImages ] ]
                    [ Html.decorativeImg
                        [ Attrs.src "/build/assets/elite-hotel-2.jpg"
                        , class [ Style.VenueSmallImage ]
                        ]
                    , Html.decorativeImg
                        [ Attrs.src "/build/assets/elite-hotel-3.jpg"
                        , class [ Style.VenueSmallImage ]
                        ]
                    ]
                , Html.decorativeImg
                    [ Attrs.src "/build/assets/elite-hotel.jpg"
                    , class [ Style.VenueImage ]
                    ]
                ]
            ]
        ]


viewCallForAbstracts : Html msg
viewCallForAbstracts =
    Html.div [ class [ Style.Venue ] ]
        [ viewTitle Light "Call for Abstracts"
        , Html.p []
            [ Html.text "We are no longer accepting Abstracts for lecture format. Abstracts may however be submitted for Poster presentation format (please see complete details in the section below) until August 30th. Notice of accepted posters is given in within 14 days after submission. To find out more and to submit an abstract for poster format, click "
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


viewPartners : Html Msg
viewPartners =
    Html.div
        [ class [ Style.Tickets ] ]
        [ viewTitle Dark "Official Partners"
        , Html.div [ class [ Style.Partners ] ]
            [ viewPartner
                "Beckley Foundation"
                "beckley-foundation.png"
                "http://beckleyfoundation.org/"
            , viewPartner
                "Psyty"
                "psyty.png"
                "http://psyty.fi/"
            , viewPartner
                "OPEN Foundation"
                "open-foundation.png"
                "http://openfoundation.nl/"
            , viewPartner
                "Heffter Research Institute"
                "heffter_logo.png"
                "https://heffter.org/"
            , viewPartner
                "Viriditas Foundation"
                "viriditas_logo.png"
                "https://viriditasfoundation.se/"
            ]
        ]


viewPartner : String -> String -> String -> Html msg
viewPartner title fileName link =
    Html.a
        [ class [ Style.Partner ]
        , Attrs.href link
        , Attrs.target "_blank"
        ]
        [ Html.decorativeImg
            [ class [ Style.PartnerImage ]
            , Attrs.alt title
            , Attrs.src <| "/build/assets/" ++ fileName
            ]
        ]


viewAccommodation : Html Msg
viewAccommodation =
    Html.div
        [ class [ Style.Tickets ] ]
        [ viewTitle Light "Accommodation"
        , Html.div [ class [ Style.Accommodation ] ]
            [ viewAccommodationItem
                "Elite Hotel Marina Tower"
                "elite-hotel-4.jpg"
                [ Html.text "Stay at the conference venue at a discount price! This 4-star hotel offers the most comfortable conference experience possible, including a breakfast buffet and state-of-the-art spa facilities. Central Stockholm is a short boat- or bus ride away. When you buy the ticket for the conference, you receive a link to make the booking. Discount rates from €125 / 1290 SEK per night. Find out more about the hotel "
                , viewSubtleLink "here" "https://www.elite.se/en/hotels/stockholm/hotel-marina-tower/"
                , Html.text "."
                ]
            , viewAccommodationItem
                "Castanea Old Town Hostel"
                "castanea-old-town-hostel.jpg"
                [ Html.text "For those of our participants travelling on a budget, Castanea Old Town Hostel is an excellent choice. Located in the heart of the city, you will still be less than 20 minutes from the conference venue by public transport. When you buy the ticket for the conference, you receive a code to make the booking. Discount rates from €23 / 240 SEK per night. Find out more about the hostel "
                , viewSubtleLink "here" "https://castaneahostel.com/en/"
                , Html.text "."
                ]
            , viewAccommodationItem
                "Couchsurfing"
                "couchsurfing.jpg"
                [ Html.text "Stay with a local! We’ll hook you up with a Swede from the psychedelic science community. It’s free, and you get to know someone with a shared interest. To find a host, simply fill out the "
                , viewSubtleLink "couchsurfing form for guests" "https://drive.google.com/open?id=12_jHXiENu2bSqJ8owIo_qighQq6AH1_WP5BrFA4d42g"
                , Html.text " and wait for us to get in touch. But - no guarantees. Couchsurfing opportunities are of course dependendent on locals signing up as hosts. To sign up as a host, fill out "
                , viewSubtleLink "this form" "https://drive.google.com/open?id=1DQCvuuqt7Gb6tSQcMU4cEewLBqqk1nsVQAFuahM_gLQ"
                , Html.text "."
                ]
            ]
        ]


viewSubtleLink : String -> String -> Html msg
viewSubtleLink title link =
    Html.a
        [ class [ Style.SubtleLink ]
        , Attrs.href link
        ]
        [ Html.text title ]


viewAccommodationItem : String -> String -> List (Html msg) -> Html msg
viewAccommodationItem title fileName content =
    Html.div
        [ class [ Style.AccommodationItem ] ]
        [ Html.decorativeImg
            [ class [ Style.AccommodationImage ]
            , Attrs.src <| "/build/assets/" ++ fileName
            ]
        , Html.h1
            [ class [ Style.AccommodationTitle ] ]
            [ Html.text title ]
        , Html.p
            [ class [ Style.AccommodationText ] ]
            content
        ]


viewSideEvents : Html Msg
viewSideEvents =
    Html.div
        [ class [ Style.Tickets ] ]
        [ viewTitle Dark "Side Events"
        , Html.div [ class [ Style.DarkText ] ]
            [ paragraph
                [ Html.text "Aside from the conference, we will host a series of events related to psychedelic psychiatry around Stockholm. These events will be open to the general public, to make the field accessible to a wider audience. More information regarding side events coming soon!" ]
            ]
        ]


viewTickets : Html Msg
viewTickets =
    Html.div
        [ class [ Style.Tickets ] ]
        [ viewTitle Light "Tickets"
        , Html.div []
            [ Html.div
                [ class [ Style.TicketsInfo ] ]
                [ column
                    [ paragraph
                        [ Html.text
                            "Early Bird tickets have sold out. However, there are a limited amount of discounted tickets! These tickets are available until July 31st or as long as they last at 3400 SEK (€330)."
                        ]
                    , paragraph
                        [ Html.div [] [ Html.text "General Release:" ]
                        , Html.div [ class [ Style.Price ] ] [ Html.text "- 3600 SEK / €350" ]
                        , Html.div [ class [ Style.Price ] ] [ Html.text "- 2400 SEK / €235 (student*)" ]
                        ]
                    , paragraph [ Html.text "TICKETS INCLUDE: Conference pass and food (breakfast, lunch and afternoon refreshments). Please state any food preferences or allergies in the form provided with ticket sales." ]
                    ]
                , column
                    [ paragraph
                        [ Html.text "All members of ‘Nätverket för Psykedelisk Vetenskap’ are eligible for a 200 SEK discount on all tickets. To receive this discount please "
                        , Html.a
                            [ class [ Style.SubtleLink ]
                            , Attrs.href "http://www.psykedeliskvetenskap.org/medlem"
                            ]
                            [ Html.text "sign up here" ]
                        , Html.text " and you will receive the discount code."
                        ]
                    , paragraph [ Html.text "*Students will be required to provide proof of registration or enrolment letter of their current university." ]
                    ]
                ]
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

                Accommodation ->
                    ( [ Style.DarkBackground ], [], viewAccommodation )

                SideEvents ->
                    ( [], [], viewSideEvents )

                Tickets ->
                    ( [ Style.DarkBackground ], [], viewTickets )

                Partners ->
                    ( [], [], viewPartners )

                CallForAbstracts ->
                    ( [ Style.DarkBackground ], [], viewCallForAbstracts )

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

        Accommodation ->
            "accommodation"

        SideEvents ->
            "side-events"

        Tickets ->
            "tickets"

        Partners ->
            "partners"

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

        Accommodation ->
            "Accommodation"

        SideEvents ->
            "Side Events"

        Tickets ->
            "Tickets"

        Partners ->
            "Partners"

        CallForAbstracts ->
            "Call for Abstracts"

        Contact ->
            "Contact"



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Ports.activeHash HashChanged
