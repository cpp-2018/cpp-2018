module Style exposing (CssClasses(..), class, css)

import Css
import Css.Elements
import Css.Media
import Css.Namespace
import Html.CssHelpers


{ class } =
    Html.CssHelpers.withNamespace namespace


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
    | SectionContent
    | Sections
    | NavBar
    | HeaderChild
    | TicketLink
    | Home
    | HomeText
    | HomeLogo
    | HomeLogoWrapper
    | About
    | CPPLogo
    | AboutIntroText
    | AboutText
    | AboutTextTitle
    | Speakers
    | SpeakersTitle
    | SpeakersTitleTop
    | SpeakersTitleBottom
    | SpeakersSpeakers
    | Speaker
    | SpeakerName
    | SpeakerText
    | SpeakerImage
    | Tickets
    | TicketsTitle
    | ContactSection
    | ContactContent
    | Contact
    | ContactText
    | ContactLeft
    | ContactTitle
    | ContactParagraph
    | ContactParagraphs
    | ContactCPPLogo
    | AboutCircle
    | AboutNPVLogo
    | Underline
    | DarkBackground


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
                { light = Css.hex "#808184"
                , dark = Css.hex "#4f4f4f"
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

        size =
            { medium =
                Css.Media.withMediaQuery
                    [ "(min-width: 751px) and (max-width: 950px)" ]
            , small =
                Css.Media.withMediaQuery
                    [ "(min-width: 551px) and (max-width: 750px)" ]
            , smaller =
                Css.Media.withMediaQuery
                    [ "(min-width: 351px) and (max-width: 550px)" ]
            , smallest =
                Css.Media.withMediaQuery
                    [ "(max-width: 350px)" ]
            }
    in
    (Css.stylesheet << Css.Namespace.namespace namespace)
        [ Css.everything
            [ Css.boxSizing Css.borderBox
            ]
        , Css.Elements.body
            [ Css.margin Css.zero
            , Css.fontFamilies [ "DIN Regular Alternate", "sans-serif" ]
            , Css.backgroundColor colors.background
            , Css.fontSize (rem 1)
            ]
        , Css.Elements.a
            [ Css.color colors.accent
            , Css.textDecoration Css.none
            , Css.textTransform Css.uppercase
            , Css.cursor Css.pointer
            ]
        , Css.class Header
            [ Css.height navBarHeight
            , Css.displayFlex
            , Css.flexDirection Css.column
            , Css.position Css.fixed
            ]
        , Css.class HeaderContent
            [ Css.displayFlex
            , Css.justifyContent Css.spaceBetween
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
            , Css.fontSize (rem 0.8)
            , Css.letterSpacing (Css.em 0.3)
            , Css.color colors.secondary.light
            , Css.hover [ Css.color colors.blue ]
            , Css.fontFamilies [ "DIN Bold", "sans-serif" ]
            ]
        , Css.class ActiveSectionLink
            [ Css.color colors.blue
            , Css.hover [ Css.color colors.blue ]
            ]
        , Css.class SectionSection
            [ Css.margin2 Css.zero Css.auto
            , Css.displayFlex
            , Css.alignItems Css.center
            , Css.justifyContent Css.center
            ]
        , Css.class SectionContent
            [ Css.maxWidth (rem 72)
            , Css.padding navBarHeight
            , size.small
                [ Css.padding2 navBarHeight (rem 3) ]
            , size.smaller
                [ Css.padding2 navBarHeight (rem 2) ]
            , size.smallest
                [ Css.padding2 navBarHeight (rem 2) ]
            ]
        , Css.class HeaderChild
            [ Css.displayFlex
            , Css.margin2 Css.zero (rem 2)
            ]
        , Css.class TicketLink
            [ Css.alignSelf Css.center
            , Css.backgroundColor colors.accent
            , Css.color colors.secondary.light
            , Css.padding2 (rem 0.5) (rem 2)
            , Css.borderRadius (Css.em 2)
            ]
        , Css.class Home
            [ Css.displayFlex
            , Css.alignItems Css.center
            , Css.alignSelf Css.center
            , Css.justifyContent Css.center
            , Css.flexGrow (Css.num 1)
            , Css.flexWrap Css.wrap
            ]
        , Css.class HomeText
            [ Css.color colors.blue
            , Css.textAlign Css.center
            , Css.fontWeight Css.bold
            , Css.fontSize (rem 1.4)
            , Css.margin (rem 3)
            , Css.flexShrink (Css.num 0)
            ]
        , Css.class HomeLogo
            [ Css.backgroundImage (Css.url "/assets/logobackground.png")
            , Css.backgroundPosition Css.center
            , Css.backgroundSize Css.cover
            , Css.width (Css.pct 100)
            , Css.flexShrink Css.zero
            ]
        , Css.class HomeLogoWrapper
            [ Css.flexGrow (Css.num 1)
            , Css.flexShrink Css.zero
            , Css.flexBasis (rem 12)
            ]
        , Css.class About
            [ Css.displayFlex
            , Css.flexGrow (Css.num 1)
            , Css.flexDirection Css.column
            , Css.children
                [ Css.everything
                    [ Css.marginBottom (rem 2)
                    ]
                ]
            ]
        , Css.class CPPLogo
            [ Css.width (Css.pct 100)
            , Css.maxWidth (rem 48)
            , Css.margin2 (rem 2) Css.auto
            ]
        , Css.class AboutIntroText
            [ Css.fontSize (rem 2)
            , Css.color colors.blue
            ]
        , Css.class AboutText
            [ Css.color colors.secondary.dark
            , Css.textAlign Css.justify
            , Css.property "column-width" "16em"
            , Css.property "column-count" "auto"
            , Css.property "column-gap" "2em"
            ]
        , Css.class AboutTextTitle
            [ Css.textTransform Css.uppercase
            , Css.fontFamilies [ "DIN Bold", "sans-serif" ]
            , Css.marginTop Css.zero
            ]
        , Css.class Speakers []
        , Css.class SpeakersTitle
            [ Css.textAlign Css.center
            , Css.marginTop (rem 1)
            ]
        , Css.class SpeakersTitleTop
            [ Css.color colors.white
            , Css.fontStyle Css.italic
            , Css.fontSize (rem 1.2)
            , Css.fontWeight Css.normal
            , Css.margin Css.zero
            ]
        , Css.class SpeakersTitleBottom
            [ Css.color colors.accent
            , Css.fontSize (rem 3.5)
            , Css.fontFamilies [ "DIN Bold", "sans-serif" ]
            , Css.fontWeight Css.normal
            , Css.margin Css.zero
            ]
        , Css.class SpeakersSpeakers
            [ Css.displayFlex
            , Css.flexWrap Css.wrap
            ]
        , Css.class Speaker
            [ Css.textAlign Css.center
            , Css.flexBasis (Css.pct 33)
            , Css.flexGrow (Css.num 1)
            , Css.marginTop (rem 4)
            , Css.padding2 Css.zero (rem 1)
            , Css.minWidth (rem 16)
            ]
        , Css.class SpeakerName
            [ Css.textTransform Css.uppercase
            , Css.color colors.accent
            ]
        , Css.class SpeakerText
            [ Css.color colors.white
            , Css.fontStyle Css.italic
            , Css.marginBottom (Css.em 0.5)
            ]
        , Css.class SpeakerImage
            [ Css.borderRadius (Css.pct 50)
            , Css.width (rem 12)
            , Css.height (rem 12)
            ]
        , Css.class Tickets
            [ Css.displayFlex
            , Css.flexDirection Css.column
            ]
        , Css.class TicketsTitle
            [ Css.color colors.blue
            , Css.fontSize (rem 2)
            , Css.fontWeight Css.bold
            , Css.textAlign Css.center
            ]
        , Css.class ContactSection
            [ gradientBackground
            ]
        , Css.class ContactContent
            [ Css.displayFlex
            , Css.flexGrow (Css.num 1)
            , Css.maxWidth (rem 96)
            ]
        , Css.class Contact
            [ Css.displayFlex
            , Css.flexGrow (Css.num 1)
            , Css.flexWrap Css.wrap
            , Css.fontSize (rem 0.85)
            , Css.lineHeight (Css.em 1.4)
            ]
        , Css.class ContactText
            [ Css.displayFlex
            , Css.marginBottom (rem 1)
            ]
        , Css.class ContactLeft
            [ Css.displayFlex
            , Css.flexGrow (Css.num 1)
            , Css.flexDirection Css.column
            , Css.marginRight (rem 2)
            ]
        , Css.class ContactTitle
            [ Css.color colors.accent
            , Css.margin Css.zero
            , Css.fontSize (rem 1.2)
            , Css.flexBasis (Css.em 8)
            , Css.textAlign Css.right
            ]
        , Css.class ContactParagraph
            [ Css.marginTop Css.zero
            ]
        , Css.class ContactParagraphs
            [ Css.textAlign Css.justify
            , Css.property "column-width" "16em"
            , Css.property "column-count" "auto"
            , Css.property "column-gap" "2em"
            , Css.color colors.white
            , Css.flexGrow (Css.num 1)
            , Css.margin2 (rem 0.5) (rem 1)
            ]
        , Css.class ContactCPPLogo
            [ Css.width (Css.pct 60)
            , Css.maxWidth (rem 48)
            , Css.marginBottom (rem 2)
            , Css.marginLeft (rem 3)
            ]
        , Css.class AboutCircle
            [ Css.borderRadius (Css.pct 50)
            , Css.backgroundColor colors.background
            , Css.color colors.blue
            , Css.displayFlex
            , Css.flexDirection Css.column
            , Css.justifyContent Css.center
            , Css.alignItems Css.center
            , Css.width (rem 24)
            , Css.height (rem 24)
            , Css.maxWidth (Css.pct 100)
            , Css.maxHeight (Css.pct 100)
            , Css.textAlign Css.center
            , Css.fontStyle Css.italic
            , Css.padding (rem 3)
            , Css.margin2 Css.zero Css.auto
            ]
        , Css.class AboutNPVLogo
            [ Css.width (rem 12)
            , Css.marginBottom (rem 1)
            ]
        , Css.class Underline
            [ Css.backgroundColor colors.accent
            , Css.width <| Css.calc (Css.pct 100) Css.minus (rem 4)
            , Css.height (rem 0.4)
            , Css.margin2 Css.zero Css.auto
            ]
        , Css.class DarkBackground
            [ Css.backgroundColor colors.secondary.dark
            ]
        ]
