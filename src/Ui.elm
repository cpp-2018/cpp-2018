module Ui exposing (bold, column, paragraph)

import Accessibility as Html exposing (Html)
import Style exposing (class)


paragraph : List (Html msg) -> Html msg
paragraph content =
    Html.p [] content


column : List (Html msg) -> Html msg
column content =
    Html.div [ class [ Style.Column ] ] content


bold : String -> Html msg
bold text =
    Html.span [ class [ Style.Bold ] ]
        [ Html.text text
        ]
