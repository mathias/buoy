module Buoy where


import Array exposing (Array, get, length)
import Maybe exposing (andThen)
import Graphics.Element exposing (Element)
import Http
import Json.Decode exposing (Decoder, (:=), array, float, tuple6)


type alias Weather =
  { airTemp : Float
  , dewpoint : Float
  , relativeHumidity : Float
  , windDir : Float
  , windSpeed : Float
  , windGust : Float
  }


-- Decoders


buoy : Decoder (Array Weather)
buoy = "data" := weatherData


weatherData : Decoder (Array Weather)
weatherData = array weather


weather : Decoder Weather
weather =
  tuple6 Weather float float float float float float
