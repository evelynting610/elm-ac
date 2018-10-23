module AudienceList exposing (..)

import Html exposing (text)

main =
  Browser.sandbox { init = init, update = update, view = view }

-- MODEL
type alias Audience = 
  { id : Int,
    name : String,
    description : String,
    creator : String,
    date_updated : Date
  }

type alias Model =
  { audiences : List Audience
  }


-- UPDATE

-- type Msg = Reset | ...

-- update : Msg -> Model -> Model
-- update msg model =
--   case msg of
--     Reset -> ...
--     ...


-- VIEW

view : Model -> Html Msg
view model =
  ...