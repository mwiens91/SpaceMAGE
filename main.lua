-- Load external libraries
lume = require "lib.lume.lume"
push = require "lib.push.push"
suit = require "lib.suit"

-- Load up global variables
require "globals"

-- Game modules
enemy = require "game.enemy"
title_menu = require "game.title_menu"


function love.load()
  -- Setup screen resolution and upscaling with push
  local window_width, window_height = love.window.getDesktopDimensions()

  push:setupScreen(
    GAME_WIDTH,
    GAME_HEIGHT,
    window_width,
    window_height,
    {
      fullscreen = true,
    }
  )

  -- Build up table of states
  states = {}
  states["title_menu"] = title_menu
  -- TODO add more states
  current_state = "title_menu"

  -- Build up a table of music tracks
  music = {}
  music["title"] = love.audio.newSource("media/audio/ambient01.ogg", "stream")

  -- DEBUG some text
  debug_text = "HEY"
end

function love.update(dt)
  -- Load the update function for the state we're in
  if states[current_state] ~= nil then
    states[current_state]:update(dt)
  end
end

function love.draw()
  push:start()

  love.graphics.print(current_state, 1200, 700)


  push:finish()
end
