module Main exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Browser exposing (Document)
import Bootstrap.Table as Table

import Html exposing (..)

type alias Flags =
    {}

main : Program Flags Model Msg
main =
  Browser.document { init = init, update = update, view = view, subscriptions = subscriptions }

-- MODEL
type alias Audience = 
  { id : Int,
    name : String,
    description : String,
    creator : String,
    date_updated : String
  }

type alias Model =
  { audiences : List Audience,
    error : String
  }

init : Flags -> ( Model, Cmd Msg )
init flags =
  ({ audiences = [ 
    {
      id = 1,
      name = "Elderly Rock Listeners",
      description = "",
      creator = "Evelyn",
      date_updated = "October 3, 2018"
    },
    {
      id = 2,
      name = "Young Wine Drinkers",
      description = "",
      creator = "Evelyn",
      date_updated = "October 7, 2018"
    }
  ],
  error = ""
  }, Cmd.none)


-- UPDATE

type Msg = Reset

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Reset -> ({ model | error = ""  }, Cmd.none)


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
                    (List.map formattedHeader ["Name", "Creator", "Date Updated"])
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
    , Table.td [] [ text audience.creator ]
    , Table.td [] [ text audience.date_updated ]
    ]