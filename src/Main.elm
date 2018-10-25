module Main exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Browser exposing (Document)
import Bootstrap.Table as Table

import Html exposing (..)
import Http
import Json.Decode exposing (Decoder, map4, field, list, string, int)
import Url.Builder as Url

type alias Flags =
    {}

main : Program Flags Model Msg
main =
  Browser.document { init = init, update = update, view = view, subscriptions = subscriptions }

-- MODEL
type alias Audience = 
  { id : Int,
    name : String,
    status : String,
    date_updated : String
  }

type alias Model =
  { audiences : List Audience
  }

init : Flags -> ( Model, Cmd Msg )
init flags =
  ({ audiences = []}, audienceResults)


-- UPDATE

type Msg = GotAudienceResults (Result Http.Error (List Audience))

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    GotAudienceResults result ->
      case result of
        Ok audiences ->
          Debug.log "okay"
          ( { model | audiences = audiences }
          , Cmd.none
          )

        Err _ ->
          ( model
          , Cmd.none
          )


-- VIEW

view : Model -> Document Msg
view model =
  { title = "Audience Center"
    , body =
        [ Grid.container []
            [ h1 [] [text "Audience Library"]
            , Table.table
            { options = [ Table.responsive ]
            , thead = Table.simpleThead
                    (List.map formattedHeader ["Name", "Status", "Date Updated"])
            , tbody = Table.tbody
                    []
                    (List.map formattedRow model.audiences)
            }
            ]
        ]
  }

formattedHeader : String  -> Table.Cell msg
formattedHeader message =
  Table.th [] [ text message ]

formattedRow : Audience  -> Table.Row msg
formattedRow audience =
  Table.tr 
    []
    [ Table.td [] [ text audience.name ]
    , Table.td [] [ text audience.status ]
    , Table.td [] [ text audience.date_updated ]
    ]

-- HTTP


audienceResults : Cmd Msg
audienceResults =
  Http.get toGetAudUrl audienceListDecoder
    |> Http.send GotAudienceResults

getAudiences : Http.Request (List String)
getAudiences =
  Http.get (toGetAudUrl) (list string)

toGetAudUrl : String
toGetAudUrl =
  Url.crossOrigin "http://localhost:3000" ["audiences"] []

audienceListDecoder : Decoder (List Audience)
audienceListDecoder =
  list audienceDecoder

audienceDecoder : Decoder Audience
audienceDecoder =
  map4 Audience
    (field "id" int)
    (field "name" string)
    (field "status" string)
    (field "date_updated" string)
