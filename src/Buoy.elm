module Buoy where


import Date exposing (Date, fromTime)
import Graphics.Element exposing (Element)
import Json.Decode exposing
  ( Decoder
  , (:=)
  , andThen
  , float
  , object6
  , string
  , succeed
  )


type alias Weather =
  { timestampSecs : Date
  , windSustainMetersPerSec : Float
  , windGustMetersPerSec : Float
  , windDirectionDegrees : Float
  , waterTempCelsius : Float
  , flagColor : Flag
  }


type Flag
  = Green
  | GreenYellow
  | Blue
  | BlueYellow
  | BlueRed
  | Red
  | Offline


-- Decoders


buoy : Decoder Weather
buoy = object6 Weather
  ("timestampSecs" := float `andThen` (fromTime >> succeed))
  ("windSustainMetersPerSec" := float)
  ("windGustMetersPerSec" := float)
  ("windDirectionDegrees" := float)
  ("waterTempCelsius" := float)
  flagColor


flagColor : Decoder Flag
flagColor =
  "flagColor" := string
    `andThen` recognizeFlag


recognizeFlag : String -> Decoder Flag
recognizeFlag flag =
  succeed <| case flag of
    "green" -> Green
    "green-yellow" -> GreenYellow
    "blue" -> Blue
    "blue-yellow" -> BlueYellow
    "blue-red" -> BlueRed
    "red" -> Red
    _ -> Offline
