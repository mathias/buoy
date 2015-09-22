module Main where


import Array exposing (Array)
import Graphics.Element exposing (Element, show)
import Http exposing (Error)
import Task exposing (Task)


import Buoy exposing
  ( Weather
  , buoy
  , display
  )


main : Element
main = display ""


fetchWeather : Task Error (Array Weather)
fetchWeather =
  Http.get buoy "http://metobs.ssec.wisc.edu/app/mendota/buoy/data/json?symbols=t:td:rh:dir:spd:gust"

port currWeather : Signal (Task x ())
port currWeather = fetchWeather
