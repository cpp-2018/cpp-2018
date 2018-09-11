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
import Ui exposing (bold, column, paragraph)


---- MODEL ----


type Visibility
    = Visible
    | Invisible


type ModalContent
    = SpeakerInfo Speaker
    | SideEventInfo (List (Html Never))


type alias Model =
    { active : Section
    , menu : Visibility
    , modal : Maybe ModalContent
    }


init : ( Model, Cmd Msg )
init =
    ( { active = About
      , menu = Invisible
      , modal = Nothing
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
    | SideEventClicked (List (Html Never))


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

        SideEventClicked info ->
            ( { model | modal = Just (SideEventInfo info) }
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


allSections : List Section
allSections =
    [ About
    , Speakers
    , Venue
    , Accommodation
    , SideEvents
    , Tickets
    , Partners
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

        Just (SideEventInfo info) ->
            viewModalContent <|
                Html.map never <|
                    Html.div
                        [ class [ Style.SpeakerModal ] ]
                        info


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
            [ viewSideEvent
                "‘From Shock to Awe’ Premiere Screening"
                "Cinemateket"
                "Oct 9th 18.00 - 21.00"
                "Shock_to_awe.jpg"
                [ paragraph
                    [ Html.h2
                        [ class [ Style.SideEventModalTitle ] ]
                        [ Html.text "‘From Shock to Awe’ Premiere Screening" ]
                    ]
                , paragraph
                    [ bold "Official Side Event, public. 364 tickets. "
                    , Html.a
                        [ Attrs.href "https://www.facebook.com/events/230803534254732"
                        , class [ Style.SideEventModalLink ]
                        ]
                        [ bold "Facebook event" ]
                    ]
                , paragraph [ Html.text "Time/Place: Cinemateket, Oct 9th 18.00 - 21.00" ]
                , paragraph [ Html.text "From Shock to Awe asks, ‘how do we heal our deepest wounds?’ An intimate and raw look at the transformational journey of two combat veterans suffering from severe trauma as they abandon pharmaceuticals to seek relief through the mind-expanding world of psychedelics. Recent scientific research coupled with a psychedelic renaissance reveals that these substances can be used to heal PTSD (Post-Traumatic Stress Disorder) for individuals and their families. Beyond the personal stories, From Shock to Awe also raises fundamental questions about war, the pharmaceutical industry, and the US legal system." ]
                , paragraph
                    [ Html.text "Watch the trailer: "
                    , Html.a
                        [ Attrs.href "https://www.fromshocktoawe.com/"
                        , class [ Style.SideEventModalLink ]
                        ]
                        [ Html.text "https://www.fromshocktoawe.com/" ]
                    ]
                , paragraph [ Html.text "Ticket price: 100 SEK / 10 EUR. Half of all proceeds after expenses will be donated to MAPS, advancing the scientific study of psychedelics to treat mental health disorders." ]
                , paragraph [ Html.text "Tickets to all side events will be released September 13th, 20.00 CEST." ]
                ]
            , viewSideEvent
                "Music Session with Mendel Kaelen"
                "Noden"
                "Oct 11th 18.00 - 21.00"
                "Music_session.jpg"
                [ paragraph
                    [ Html.h2
                        [ class [ Style.SideEventModalTitle ] ]
                        [ Html.text "Music Session with Mendel Kaelen" ]
                    ]
                , paragraph
                    [ bold "Official Side Event, public. 100 tickets. "
                    , Html.a
                        [ Attrs.href "https://www.facebook.com/events/269583826985900"
                        , class [ Style.SideEventModalLink ]
                        ]
                        [ bold "Facebook event" ]
                    ]
                , paragraph [ Html.text "Time/Place: Noden, October 11th 18.00 - 21.00" ]
                , paragraph [ Html.text "Mendel Kaelen is a neuroscientist and entrepreneur. His research focus is on the therapeutic function of set and setting in psychedelic therapy, with a particular focus on music. He is founder and CEO of Wavepaths, a venture that brings together immersive arts, psychotherapies and AI technologies into a new category of therapeutic tools. This evening we’ll have the opportunity of immersing ourselves in the the science of set and setting, guided by Mendel himself." ]
                , paragraph [ Html.text "Tickets are limited and expected to sell out fast. General Admission 250 SEK / 25 EUR, CPP ticket holder 150 SEK / 15 EUR" ]
                , paragraph [ Html.text "Tickets to all side events will be released September 13th, 20.00 CEST." ]
                ]
            , viewSideEvent
                "Integration Masterclass for Clinicians"
                "Noden"
                "Oct 12th 13.00 - 17.00"
                "Integration_masterclass.jpg"
                [ paragraph
                    [ Html.h2
                        [ class [ Style.SideEventModalTitle ] ]
                        [ Html.text "Integration Masterclass for Clinicians" ]
                    ]
                , paragraph
                    [ bold "Official Side Event, practising healthcare practitioners only. 40 tickets. "
                    , Html.a
                        [ Attrs.href "https://www.facebook.com/events/2051722494846227"
                        , class [ Style.SideEventModalLink ]
                        ]
                        [ bold "Facebook event" ]
                    ]
                , paragraph
                    [ Html.text "Time/Place: Noden, Oct 12th 13.00 - 17.00"
                    , paragraph [ Html.text "Integration has become a main subject of discussion in the field of psychedelic science. While its importance is widely acknowledged, there are different interpretations of what integration is, its objectives and the scope of it. Different integration resources have appeared during the last years, as well as a wide variety of people offering integration services." ]
                    , paragraph
                        [ Html.text "This masterclass offers an in-depth view of what integration is, and how one can support clients in this process. We will present data from the ICEERS Integration and Support service, and we will have practical exercises to convey the most important foundations of integration work. The contents of this class include:"
                        , Html.ul []
                            [ Html.li [] [ Html.text "Definitions of integration" ]
                            , Html.li [] [ Html.text "Classic integration approaches" ]
                            , Html.li [] [ Html.text "Emergency integration interventions" ]
                            , Html.li [] [ Html.text "Psychotherapeutic needs in integration sessions" ]
                            , Html.li [] [ Html.text "Integration vs. Psychotherapy" ]
                            , Html.li [] [ Html.text "Case Studies of real integration sessions" ]
                            , Html.li [] [ Html.text "Experiential dynamics around integration" ]
                            ]
                        ]
                    , paragraph
                        [ Html.h3 [] [ Html.text "About the facilitator" ]
                        , Html.text "Marc Aixalà is a licensed psychologist and psychotherapist with post degree studies in Integrative Psychotherapy, Masters in Strategic Therapy, and is trained in the therapeutic use of Non Ordinary States of Consciousness, and in MDMA assisted-psychotherapy for PTSD. He coordinates support services at ICEERS where he provides integration psychotherapy sessions for people in challenging situations after experiences with non-ordinary states of consciousness since 2013. Marc works as a psychotherapist in Barcelona, a Holotropic Breathwork facilitator, and is a member of the staff for Grof Transpersonal Training. He has facilitated Holotropic Breathwork workshops and trainings in Barcelona, Switzerland, Unites States, Romania, Israel and Slovenia and is conducting research into its therapeutic applications. He has also been a Team Leader and Trainer at the Kosmicare psychedelic harm reduction service at the Boom Festival, and a trainer for psilocybin guides at the Imperial College London."
                        ]
                    , paragraph
                        [ Html.h3 [] [ Html.text "Application procedure" ]
                        , Html.text "The deadline for applications is September 30th. Priority will be given to those with 1) relevant education and 2) clinical work experience. After submission, each applicant will be contacted. Applicants with relevant education and work experience will be immediately offered to participate , others will be placed on a reserve list. Following the application deadline, applicants on the reserve list will be contacted again regarding participation."
                        ]
                    , paragraph
                        [ Html.text "Apply "
                        , Html.a
                            [ Attrs.href "https://goo.gl/forms/vVlLvIIwx8Uk9rc62"
                            , class [ Style.SideEventModalLink ]
                            ]
                            [ bold "here" ]
                        ]
                    , paragraph
                        [ Html.text "Course fee: General Admission 700 SEK/70 EUR, CPP participant 400 SEK/40 EUR." ]
                    ]
                ]
            , viewSideEvent
                "Official After Party"
                "Noden"
                "Oct 14th 21.00 - late"
                "Official_afterparty.jpg"
                [ paragraph
                    [ Html.h2
                        [ class [ Style.SideEventModalTitle ] ]
                        [ Html.text "CPP2018 Official After Party" ]
                    ]
                , paragraph
                    [ bold "Official Side Event, public. 300 tickets. "
                    , Html.a
                        [ Attrs.href "https://www.facebook.com/events/536527963454680"
                        , class [ Style.SideEventModalLink ]
                        ]
                        [ bold "Facebook event" ]
                    ]
                , paragraph
                    [ Html.text "Time/Place: Noden, Oct 14th, 21.00 - 05.00"
                    , paragraph
                        [ Html.text "The Swedish Network for Psychedelic Science proudly presents, the official after party of Colloquium on Psychedelic Psychiatry 2018! To find out more about the conference, check out "
                        , Html.a
                            [ Attrs.href "http://cpp2018.se"
                            , class [ Style.SideEventModalLink ]
                            ]
                            [ bold "http://cpp2018.se" ]
                        , Html.text "."
                        ]
                    ]
                , paragraph [ Html.text "After an intense weekend of lectures and presentations, we gather one last time at Noden to say goodbye and shake it all out. Live performances, dj's and art installations to be announced. Stay tuned!" ]
                , paragraph [ Html.text "Ticket price: General Admission 200 SEK / 20 EUR, CPP ticket holder 100 SEK / 10 EUR" ]
                , paragraph [ Html.text "Tickets to all side events will be released September 13th, 20.00 CEST." ]
                ]
            , viewSideEvent
                "Post-Conference Researcher’s Retreat"
                "Ekskäret"
                "Oct 15th-17th"
                "Post_Retreat.jpeg"
                [ paragraph
                    [ Html.h2
                        [ class [ Style.SideEventModalTitle ] ]
                        [ Html.text "Post-Conference Researcher’s Retreat" ]
                    ]
                , paragraph [ bold "Official Side Event, public. X tickets. No facebook event" ]
                , paragraph [ Html.text "Time/Place: Ekskäret, Stockholm archipelago. Oct 15th-17th" ]
                , paragraph [ Html.text "Efter konferensen kommer några av talarna och besökarna att åka ut i Skärgården till den idylliska ön Ekskäret. Det blir ett perfekt tillfälle att koppla av i två dagar, men också för att nätverka och planera framtida projekt med lokala och internationella kollegor och andra." ]
                ]
            ]
        ]


viewSideEvent : String -> String -> String -> String -> List (Html Never) -> Html Msg
viewSideEvent title location time fileName info =
    CoreHtml.div
        [ class [ Style.SideEventItem ]
        , Events.onClick <| SideEventClicked info
        ]
        [ Html.decorativeImg
            [ class [ Style.SideEventImage ]
            , Attrs.src <| "/build/assets/side-events/" ++ fileName
            ]
        , Html.h1
            [ class [ Style.SideEventTitle ] ]
            [ Html.text title ]
        , Html.p
            [ class [ Style.SideEventText ] ]
            [ Html.text location ]
        , Html.p
            [ class [ Style.SideEventText ] ]
            [ Html.text time ]
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
