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
    | HamburgerMenuButton
    | HamburgerMenuButtonImg
    | HamburgerMenuMenu
    | BigNav
    | SmallNav
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
    | ContactTextContent
    | ContactContactInfo
    | ContactCPPLogo
    | AboutCircle
    | AboutNPVLogo
    | Underline
    | DarkBackground
    | MoreInfoSoon


css : Css.Stylesheet
css =
    let
        navBarHeight : Css.Rem
        navBarHeight =
            Css.rem 5

        colors =
            { background = Css.hex "#fff7f5"
            , white = Css.hex "#ffffff"
            , primary = Css.hex "#0000ff"
            , secondary = Css.hex "#ff9c8a"
            , accent = Css.hex "#6affc2"
            , neutral =
                { light = Css.hex "#808184"
                , dark = Css.hex "#4f4f4f"
                }
            }

        gradientBackground =
            Css.backgroundImage <|
                Css.linearGradient2
                    Css.toRight
                    (Css.stop colors.primary)
                    (Css.stop colors.secondary)
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
            , navLimit =
                Css.Media.withMediaQuery
                    [ "(max-width: 650px)" ]
            }

        maxSectionContentWidth =
            Css.calc (Css.vw 100) Css.minus (Css.rem 4)
    in
    (Css.stylesheet << Css.Namespace.namespace namespace)
        [ Css.everything
            [ Css.boxSizing Css.borderBox
            ]
        , Css.Elements.html
            [ Css.fontSize (Css.px 14)
            ]
        , Css.Elements.body
            [ Css.margin Css.zero
            , Css.fontFamilies [ "DIN Regular Alternate", "sans-serif" ]
            , Css.backgroundColor colors.background
            , Css.fontSize (Css.rem 1)
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
            [ Css.height (Css.rem 0.5)
            , gradientBackground
            ]
        , Css.class HamburgerMenuButton
            [ Css.backgroundColor colors.background
            , Css.border Css.zero
            , Css.borderStyle Css.none
            , Css.padding Css.zero
            , Css.cursor Css.pointer
            , Css.color colors.neutral.light
            , Css.hover [ Css.color colors.neutral.dark ]
            , Css.children
                [ Css.Elements.svg
                    [ Css.margin2 Css.zero (Css.rem 1)
                    ]
                ]
            ]
        , Css.class HamburgerMenuButtonImg
            [ Css.padding (Css.rem 1)
            ]
        , Css.class HamburgerMenuMenu
            [ Css.position Css.absolute
            , Css.top (Css.pct 100)
            , Css.right Css.zero
            , Css.fontSize (Css.em 1.5)
            , Css.backgroundColor colors.background
            , Css.padding (Css.rem 1)
            , Css.border3 (Css.px 1) Css.solid colors.neutral.light
            , Css.descendants
                [ Css.class SectionLink
                    [ Css.marginBottom (Css.em 1)
                    , Css.lastChild
                        [ Css.marginBottom Css.zero ]
                    ]
                ]
            ]
        , Css.class BigNav
            [ Css.displayFlex
            , Css.margin2 Css.zero (Css.rem 2)
            , size.navLimit [ Css.display Css.none ]
            ]
        , Css.class SmallNav
            [ Css.display Css.none
            , Css.flexGrow (Css.num 1)
            , Css.position Css.relative
            , Css.justifyContent Css.flexEnd
            , size.navLimit [ Css.displayFlex ]
            ]
        , Css.class Sections
            []
        , Css.class SectionLink
            [ Css.padding2 Css.zero (Css.rem 1)
            , Css.displayFlex
            , Css.alignItems Css.center
            , Css.fontSize (Css.em 0.8)
            , Css.letterSpacing (Css.em 0.3)
            , Css.color colors.neutral.light
            , Css.hover [ Css.color colors.primary ]
            , Css.fontFamilies [ "DIN Bold", "sans-serif" ]
            ]
        , Css.class ActiveSectionLink
            [ Css.color colors.primary
            , Css.hover [ Css.color colors.primary ]
            ]
        , Css.class SectionSection
            [ Css.margin2 Css.zero Css.auto
            , Css.displayFlex
            , Css.alignItems Css.center
            , Css.justifyContent Css.center
            ]
        , Css.class SectionContent
            [ Css.maxWidth (Css.rem 72)
            , Css.padding navBarHeight
            , size.small
                [ Css.padding2 navBarHeight (Css.rem 3) ]
            , size.smaller
                [ Css.padding2 navBarHeight (Css.rem 2) ]
            , size.smallest
                [ Css.padding2 navBarHeight (Css.rem 2) ]
            ]
        , Css.class TicketLink
            [ Css.alignSelf Css.center
            , Css.backgroundColor colors.accent
            , Css.color colors.neutral.light
            , Css.padding2 (Css.rem 0.5) (Css.rem 2)
            , Css.margin2 Css.zero (Css.rem 2)
            , Css.borderRadius (Css.em 2)
            , Css.alignItems Css.center
            , Css.fontSize (Css.rem 0.8)
            , Css.letterSpacing (Css.em 0.3)
            , Css.hover [ Css.color colors.primary ]
            , Css.fontFamilies [ "DIN Bold", "sans-serif" ]
            ]
        , Css.class Home
            [ Css.displayFlex
            , Css.alignItems Css.center
            , Css.alignSelf Css.center
            , Css.justifyContent Css.center
            , Css.flexGrow (Css.num 1)
            , size.small [ Css.flexDirection Css.column ]
            , size.smaller [ Css.flexDirection Css.column ]
            , size.smallest [ Css.flexDirection Css.column ]
            ]
        , Css.class HomeText
            [ Css.color colors.primary
            , Css.textAlign Css.center
            , Css.fontWeight Css.bold
            , Css.fontSize (Css.rem 1.4)
            , Css.margin (Css.rem 3)
            , Css.flexShrink (Css.num 0)
            ]
        , Css.class HomeLogo
            [ Css.backgroundImage (Css.url "/docs/assets/logobackground.png")
            , Css.backgroundColor colors.primary
            , Css.backgroundPosition Css.center
            , Css.backgroundSize Css.cover
            , Css.flexShrink Css.zero
            , Css.display Css.block
            , Css.margin2 Css.zero Css.auto
            , Css.width (Css.pct 100)
            , size.small [ Css.width (Css.pct 50) ]
            , size.smaller [ Css.width (Css.pct 75) ]
            , size.smallest [ Css.width (Css.pct 100) ]
            ]
        , Css.class HomeLogoWrapper
            [ Css.flexGrow (Css.num 1)
            , Css.flexShrink Css.zero
            , Css.flexBasis (Css.rem 12)
            , size.small [ Css.order (Css.num -1) ]
            , size.smaller [ Css.order (Css.num -1) ]
            , size.smallest [ Css.order (Css.num -1) ]
            ]
        , Css.class About
            [ Css.displayFlex
            , Css.flexGrow (Css.num 1)
            , Css.flexDirection Css.column
            , Css.children
                [ Css.everything
                    [ Css.marginBottom (Css.rem 2)
                    ]
                ]
            ]
        , Css.class CPPLogo
            [ Css.width (Css.pct 100)
            , Css.maxWidth (Css.rem 48)
            , Css.margin2 (Css.rem 2) Css.zero
            ]
        , Css.class AboutIntroText
            [ Css.fontSize (Css.rem 2)
            , Css.color colors.primary
            ]
        , Css.class AboutText
            [ Css.color colors.neutral.dark
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
            , Css.marginTop (Css.rem 1)
            ]
        , Css.class SpeakersTitleTop
            [ Css.color colors.white
            , Css.fontStyle Css.italic
            , Css.fontSize (Css.rem 1.2)
            , Css.fontWeight Css.normal
            , Css.margin Css.zero
            ]
        , Css.class SpeakersTitleBottom
            [ Css.color colors.accent
            , Css.fontSize (Css.rem 3.5)
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
            , Css.marginTop (Css.rem 4)
            , Css.padding2 Css.zero (Css.rem 1)
            , Css.minWidth (Css.rem 16)
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
            , Css.width (Css.rem 12)
            , Css.height (Css.rem 12)
            ]
        , Css.class Tickets
            [ Css.displayFlex
            , Css.flexDirection Css.column
            ]
        , Css.class TicketsTitle
            [ Css.color colors.primary
            , Css.fontSize (Css.rem 2)
            , Css.fontWeight Css.bold
            , Css.textAlign Css.center
            ]
        , Css.class ContactSection
            [ gradientBackground
            ]
        , Css.class ContactContent
            [ Css.displayFlex
            , Css.flexGrow (Css.num 1)
            , Css.maxWidth (Css.rem 96)
            ]
        , Css.class Contact
            [ Css.displayFlex
            , Css.flexGrow (Css.num 1)
            , Css.flexWrap Css.wrap
            , Css.fontSize (Css.rem 0.85)
            , Css.lineHeight (Css.em 1.4)
            ]
        , Css.class ContactText
            [ Css.displayFlex
            , Css.marginBottom (Css.rem 1)
            ]
        , Css.class ContactLeft
            [ Css.displayFlex
            , Css.flexGrow (Css.num 1)
            , Css.flexDirection Css.column
            , Css.marginRight (Css.rem 2)
            ]
        , Css.class ContactTitle
            [ Css.color colors.accent
            , Css.margin Css.zero
            , Css.fontSize (Css.rem 1.2)
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
            ]
        , Css.class ContactTextContent
            [ Css.color colors.white
            , Css.flexGrow (Css.num 1)
            , Css.margin2 (Css.rem 0.5) (Css.rem 1)
            ]
        , Css.class ContactContactInfo
            [ Css.marginBottom (Css.rem 1) ]
        , Css.class ContactCPPLogo
            [ Css.width (Css.pct 60)
            , Css.maxWidth (Css.rem 48)
            , Css.marginBottom (Css.rem 2)
            , Css.marginLeft (Css.rem 3)
            ]
        , Css.class AboutCircle
            [ Css.borderRadius (Css.pct 50)
            , Css.backgroundColor colors.background
            , Css.color colors.primary
            , Css.displayFlex
            , Css.flexDirection Css.column
            , Css.justifyContent Css.center
            , Css.alignItems Css.center
            , Css.width (Css.rem 24)
            , Css.height (Css.rem 24)
            , Css.maxWidth maxSectionContentWidth
            , Css.maxHeight maxSectionContentWidth
            , Css.textAlign Css.center
            , Css.fontStyle Css.italic
            , Css.padding (Css.rem 3)
            , Css.margin2 Css.zero Css.auto
            , size.smallest
                [ Css.fontSize (Css.em 0.8)
                , Css.lineHeight (Css.em 1.2)
                ]
            ]
        , Css.class AboutNPVLogo
            [ Css.width (Css.pct 66)
            , Css.marginBottom (Css.rem 1)
            ]
        , Css.class Underline
            [ Css.backgroundColor colors.accent
            , Css.width <| Css.calc (Css.pct 100) Css.minus (Css.rem 4)
            , Css.height (Css.rem 0.4)
            , Css.margin2 Css.zero Css.auto
            ]
        , Css.class DarkBackground
            [ Css.backgroundColor colors.neutral.dark
            ]
        , Css.class MoreInfoSoon
            [ Css.textAlign Css.center
            , Css.textTransform Css.uppercase
            , Css.color colors.white
            , Css.fontSize (Css.rem 2)
            ]
        ]
