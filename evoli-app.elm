-- Walk around with the arrow keys. Press the UP arrow to jump!
--
-- Learn more about the playground here:
--   https://package.elm-lang.org/packages/evancz/elm-playground/latest/
--


import Playground exposing (..)


-- MAIN


main =
  game view update
    { x = 0
    , y = 0
    , vx = 0
    , vy = 0
    , dir = "right"
    }


-- VIEW


view computer evoli =
  let
    w = computer.screen.width
    h = computer.screen.height
    b = computer.screen.bottom
  in
  [ rectangle (rgb 174 238 238) w h
  , rectangle (rgb 74 163 41) w 100
      |> moveY b
  , image 170 170 (toGif evoli)
      |> move evoli.x (b + 120 + evoli.y)
  ]


toGif evoli =
  if evoli.y > 0 then
    "https://raw.githubusercontent.com/nini/PokemonApp/main/images/evoli/jump/" ++ evoli.dir ++ ".gif"
  else if evoli.vx /= 0 then
    "https://raw.githubusercontent.com/nini/PokemonApp/main/images/evoli/walk/" ++ evoli.dir ++ ".gif"
  else
    "https://raw.githubusercontent.com/nini/PokemonApp/main/images/evoli/stand/" ++ evoli.dir ++ ".gif"



-- UPDATE


update computer evoli =
  let
    dt = 1.666
    vx = toX computer.keyboard
    vy =
      if evoli.y == 0 then
        if computer.keyboard.up then 5 else 0
      else
        evoli.vy - dt / 8
    x = evoli.x + dt * vx
    y = evoli.y + dt * vy
  in
  { x = x
  , y = max 0 y
  , vx = vx
  , vy = vy
  , dir = if vx == 0 then evoli.dir else if vx < 0 then "left" else "right"
  }