module Components.File exposing (..)

import Html exposing (..)
import Html.Attributes as HA
import Markdown
import Octicons


type alias Options =
    { fileName : String
    , contents : String
    , class_ : String
    , enableCopyButton : Bool
    }


defaultOptions : Options
defaultOptions =
    { fileName = ""
    , contents = ""
    , class_ = ""
    , enableCopyButton = True
    }


fileName : String -> Options -> Options
fileName value options =
    { options | fileName = value }


contents : String -> Options -> Options
contents value options =
    { options | contents = value }


class : String -> Options -> Options
class value options =
    { options | class_ = value }


enableCopyButton : Bool -> Options -> Options
enableCopyButton value options =
    { options | enableCopyButton = value }


view : Options -> Html msg
view options =
    div
        [ HA.class <| "border border-slate-300 rounded-md shadow-sm overflow-hidden" ++ options.class_ ]
        [ div [ HA.class "flex items-center justify-between px-4 py-2 border-b border-slate-300 bg-slate-100" ] <|
            h3
                [ HA.class "inline-flex items-center text-slate-800 font-medium py-2"
                ]
                [ Octicons.defaultOptions |> Octicons.color "currentColor" |> Octicons.size 16 |> Octicons.class "inline shrink-0" |> Octicons.file
                , span [ HA.class "ml-2" ] [ text options.fileName ]
                ]
                :: (if options.enableCopyButton then
                        [ button
                            [ HA.class "ml-2 inline-flex items-center text-sm text-white font-medium pl-2 pr-3 py-2 shadow-sm rounded bg-blue-900 hover:bg-blue-600"
                            , HA.type_ "button"
                            ]
                            [ Octicons.defaultOptions |> Octicons.color "currentColor" |> Octicons.size 15 |> Octicons.class "inline" |> Octicons.clippy
                            , span [ HA.class "ml-2" ] [ text "Copy" ]
                            ]
                        ]

                    else
                        []
                   )
        , pre []
            [ Markdown.toHtml [ HA.class "px-4 py-4 content overflow-x-scroll" ] options.contents
            ]
        ]
