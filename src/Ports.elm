port module Ports exposing (activeHash, setupScrollSpy)


port activeHash : (String -> msg) -> Sub msg


port setupScrollSpy : List String -> Cmd msg
