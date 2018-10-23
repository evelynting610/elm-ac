module Main exposing (..)
import Browser
import Bootstrap.Table as Table

import Html exposing (..)

main =
  Browser.sandbox { init = init, update = update, view = view }

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

init : Model
init =
  { audiences = [ 
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
  }


-- UPDATE

type Msg = Reset

update : Msg -> Model -> Model
update msg model =
  case msg of
    Reset -> { model | error = ""  }


-- VIEW

view : Model -> Html Msg
view model =
    Table.table
      { options = [ Table.striped ]
      , thead = Table.simpleThead
            (List.map formattedHeader ["Name", "Creator", "Date Updated"])
      , tbody = Table.tbody
            []
            (List.map formattedRow model.audiences)
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