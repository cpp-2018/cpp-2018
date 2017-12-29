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
    | Sections
    | NavBar
    | HeaderChild
    | TicketLink


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
                { light = Css.hex "f8f8f8"
                , dark = Css.hex "#808184"
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
            , Css.fontFamily Css.sansSerif
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
            , Css.fontFamilies
                [ "DIN Bold"
                , "DIN Regular Alternate"
                , "sans-serif"
                ]
            , Css.color colors.secondary.dark
            , Css.hover [ Css.color colors.blue ]
            ]
        , Css.class ActiveSectionLink
            [ Css.color colors.blue
            , Css.hover [ Css.color colors.blue ]
            ]
        , Css.class SectionSection
            [ Css.minHeight (Css.vh 100)
            , Css.paddingTop navBarHeight
            , Css.nthChild "odd"
                [ Css.backgroundColor colors.secondary.light
                ]
            , Css.nthChild "even"
                [ Css.backgroundColor colors.secondary.dark
                ]
            ]
        , Css.class HeaderChild
            [ Css.displayFlex
            , Css.margin2 (rem 0) (rem 2)
            ]
        , Css.class TicketLink
            [ Css.alignSelf Css.center
            , Css.backgroundColor colors.accent
            , Css.color colors.secondary.dark
            , Css.padding2 (rem 0.5) (rem 2)
            , Css.borderRadius (Css.em 2)
            ]
        ]
