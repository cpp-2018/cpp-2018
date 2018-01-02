module Style exposing (CssClasses(..), class, css)

import Css
import Css.Elements
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
    | HomeTextBorder
    | About
    | AboutTitle
    | AboutTitleLeft
    | AboutTitleRight
    | AboutTitleRightTop
    | AboutTitleRightBottom
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
            [ Css.minHeight (Css.vh 100)
            , Css.margin2 Css.zero Css.auto
            , Css.displayFlex
            , Css.alignItems Css.center
            , Css.justifyContent Css.center
            ]
        , Css.class SectionContent
            [ Css.maxWidth (rem 72)
            , Css.padding navBarHeight
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
            ]
        , Css.class HomeText
            [ Css.color colors.blue
            , Css.textAlign Css.center
            , Css.fontWeight Css.bold
            , Css.fontSize (rem 1.4)
            , Css.margin (rem 3)
            ]
        , Css.class HomeTextBorder
            [ Css.backgroundColor colors.accent
            , Css.height (rem 0.4)
            , Css.width (rem 4)
            , Css.margin2 Css.zero Css.auto
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
        , Css.class AboutTitle
            [ Css.displayFlex
            , Css.fontFamilies [ "DIN Bold", "sans-serif" ]
            , Css.alignItems Css.center
            , Css.property "align-items" "last baseline"
            ]
        , Css.class AboutTitleLeft
            [ Css.color colors.accent
            , Css.fontSize (rem 10)
            ]
        , Css.class AboutTitleRight [ Css.color colors.blue ]
        , Css.class AboutTitleRightTop
            [ Css.fontSize (rem 2)
            , Css.fontStyle Css.italic
            ]
        , Css.class AboutTitleRightBottom
            [ Css.fontSize (rem 4)
            ]
        , Css.class AboutIntroText
            [ Css.fontSize (rem 2)
            , Css.color colors.blue
            ]
        , Css.class AboutText
            [ Css.color colors.secondary.dark
            , Css.property "column-count" "3"
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
        , Css.class DarkBackground
            [ Css.backgroundColor colors.secondary.dark
            ]
        ]
