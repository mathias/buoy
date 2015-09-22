module Buoy where


import Array exposing
  ( Array
  , get
  , length
  , slice
  )
import Maybe exposing (andThen)
import Graphics.Element exposing
  ( Element
  , show
  )
import Http
import Json.Decode exposing
  ( Decoder
  , (:=)
  , array
  , decodeString
  , float
  , tuple6
  )


type alias Weather =
  { airTemp : Float
  , dewpoint : Float
  , relativeHumidity : Float
  , windDir : Float
  , windSpeed : Float
  , windGust : Float
  }


display : String -> Element
display txt = case decodeString buoy txt of
  Ok val ->
    case lastElement val of
      Nothing -> show "Empty weather data"
      Just x -> show x
  Err e -> show "Couldn't decode weather data"


lastElement : Array a -> Maybe a
lastElement arr = get (length arr - 1) arr


buoy : Decoder (Array Weather)
buoy = "data" := weatherData


weatherData : Decoder (Array Weather)
weatherData = array weather


weather : Decoder Weather
weather =
  tuple6 Weather float float float float float float
