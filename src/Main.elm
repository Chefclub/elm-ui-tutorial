module Main exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)


type alias Message =
    { author : String, time : String, text : String }


channelPanel : List String -> String -> Element msg
channelPanel channels activeChannel =
    let
        activeChannelAttrs =
            [ Background.color <| rgb255 117 179 201, Font.bold ]

        channelAttrs =
            [ paddingXY 15 5, width fill ]

        channelEl channel =
            el
                (if channel == activeChannel then
                    activeChannelAttrs ++ channelAttrs

                 else
                    channelAttrs
                )
            <|
                text ("# " ++ channel)
    in
    column
        [ height fill
        , width <| fillPortion 1
        , paddingXY 0 10
        , Background.color <| rgb255 92 99 118
        , Font.color <| rgb255 255 255 255
        ]
    <|
        List.map channelEl channels


chatPanel : String -> List Message -> Element msg
chatPanel channel messages =
    let
        header =
            row
                [ width fill
                , paddingXY 20 5
                , Border.widthEach { bottom = 1, top = 0, left = 0, right = 0 }
                , Border.color <| rgb255 200 200 200
                ]
                [ el [] <| text ("#" ++ channel)
                , Input.button
                    [ padding 5
                    , alignRight
                    , Border.width 1
                    , Border.rounded 3
                    , Border.color <| rgb255 200 200 200
                    ]
                    { onPress = Nothing
                    , label = text "Search"
                    }
                ]

        messageEntry message =
            column [ width fill, spacingXY 0 5 ]
                [ row [ spacingXY 10 0 ]
                    [ el [ Font.bold ] <| text message.author, text message.time ]
                , paragraph [] [ text message.text ]
                ]

        messagePanel =
            column [ padding 10, spacingXY 0 20, scrollbarY ] <|
                List.map messageEntry messages

        footer =
            el [ alignBottom, padding 20, width fill ] <|
                row
                    [ spacingXY 2 0
                    , width fill
                    , Border.width 2
                    , Border.rounded 4
                    , Border.color <| rgb255 200 200 200
                    ]
                    [ el
                        [ padding 5
                        , Border.widthEach { right = 2, left = 0, top = 0, bottom = 0 }
                        , Border.color <| rgb255 200 200 200
                        , mouseOver [ Background.color <| rgb255 86 182 139 ]
                        ]
                      <|
                        text "+"
                    , el [ Background.color <| rgb255 255 255 255 ] none
                    ]
    in
    column [ height fill, width <| fillPortion 5 ]
        [ header
        , messagePanel
        , footer
        ]


main : Html msg
main =
    let
        channel =
            "tech"

        messages =
            [ { author = "Rémy", time = "12:57", text = "Je vais faire un test avec elm-ui 🕴" }
            , { author = "Greg", time = "13:07", text = "N'y passe pas trop de temps on va attendre Janvier pour en discuter 🙊" }
            , { author = "Yannick", time = "13:17", text = "Plus il y a de @elmlang mieux c'est de toute manière 😎" }
            , { author = "Greg", time = "13:18", text = "Ça ne t'empêche pas de regarder elm-ui 🚎" }
            , { author = "Rémy", time = "13:19", text = "Mon objectif c'est d'avoir quelques mockup pour valider que ce que j'ai compris fonctionne " }
            , { author = "Rémy", time = "13:19", text = "Je suis un codeur pas un designer du coup je sais pas faire des mockups sans coder 😢" }
            ]
    in
    layout [ height fill ] <|
        row [ height fill, width fill ]
            [ channelPanel [ "general", "tech", "manger", "noël" ] channel
            , chatPanel channel messages
            ]
