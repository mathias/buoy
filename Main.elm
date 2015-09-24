module Main where


import Graphics.Element exposing (Element, show)
import Http exposing (Error(..))
import Signal exposing (Mailbox, send)
import Task exposing (Task, andThen, toResult)
import Time exposing (Time, every, minute)

import Buoy exposing (Weather, buoy)


url : String
url = "/buoy.json" -- serve with Elm Reactor
-- Uncomment me with an Access-Control-Allow-Origin domain!
-- url = "http://metobs.ssec.wisc.edu/app/mendota/buoy/data/json?symbols=t:td:rh:dir:spd:gust"


main : Signal Element
main = Signal.map display results.signal


display : Result Error Weather -> Element
display resp =
  case resp of
    Err e -> show e
    Ok v -> show v


fetchWeather : Task Error Weather
fetchWeather = Http.get buoy url


results : Mailbox (Result Error Weather)
results =
  Signal.mailbox (Err NetworkError)


port currWeather : Signal (Task x ())
port currWeather =
  let fetch _ = toResult fetchWeather `andThen` send results.address
  in
      Signal.map fetch (every minute)
