module Ui exposing (column, paragraph)

import Accessibility as Html exposing (Html)
import Style exposing (class)


paragraph : List (Html msg) -> Html msg
paragraph content =
    Html.p [] content


column : List String -> Html msg
column paragraphs =
    Html.div [ class [ Style.Column ] ] <|
        List.map (paragraph << List.singleton << Html.text) paragraphs
