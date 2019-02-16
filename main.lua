-- Load external libraries
lume = require "lib.lume.lume"
push = require "lib.push.push"
suit = require "lib.suit"

-- Load up global variables
require "globals"

-- Game modules
enemies = require "game.enemies"
projectiles = require "game.projectiles"
planets = require "game.planets"
ship = require "game.mainship"
space_combat = require "game.space_combat"
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
  states["space_combat"] = space_combat
  current_state = "title_menu"

  -- Build up a table of music tracks
  music = {}
  music["title"] = love.audio.newSource("media/audio/music/ambient01.ogg", "stream")
  music["preparation"] = love.audio.newSource("media/audio/music/pensive01.ogg", "stream")
  music["space_combat"] = love.audio.newSource("media/audio/music/pensive02.ogg", "stream")

  -- Build up a table of SFX
  sfx = {}
  sfx["menu_long_01"] = love.audio.newSource("media/audio/sfx/menu_long_01.ogg", "static")
  sfx["menu_short_01"] = love.audio.newSource("media/audio/sfx/menu_short_01.ogg", "static")
  sfx["menu_short_02"] = love.audio.newSource("media/audio/sfx/menu_short_02.ogg", "static")

  -- Load the main font
  font_default = love.graphics.newFont(FONT_PATH, DEFAULT_FONT_SIZE)
  font_quote = love.graphics.newFont(FONT_PATH, QUOTE_FONT_SIZE)
  font_title = love.graphics.newFont(FONT_PATH, TITLE_FONT_SIZE)

  -- Starting drone counts
  drone_counts = {
    drones_attack = 2.734159e7,
    drones_exploration = 2.1231e6,
    drones_mining = 3.14159e9,
  }

  -- Load ship
  ship.load()

  -- Variable indicating whether to show stats on the screen
  show_side_stats = false
end

function love.update(dt)
  -- Load the update function for the state we're in
  if states[current_state] ~= nil then
    states[current_state]:update(dt)
  end
end

function love.draw()
  push:start()

  -- Load the draw function for the state we're in
  if states[current_state] ~= nil then
    states[current_state]:draw()
  end

  -- Show stats around the screen
  if show_side_stats then
    love.graphics.setColor(0.7, 0.7, 0.7, 1)

    -- Show drone stats
    love.graphics.printf(
      "drones_exploring " .. drone_counts["drones_exploration"],
      10,
      GAME_HEIGHT - 300,
      GAME_WIDTH,
      "left"
    )
    love.graphics.printf(
      "drones_mining " .. drone_counts["drones_mining"],
      10,
      GAME_HEIGHT - 275,
      GAME_WIDTH,
      "left"
    )
    love.graphics.printf(
      "drones_attacking " .. drone_counts["drones_attack"],
      10,
      GAME_HEIGHT - 250,
      GAME_WIDTH,
      "left"
    )

    love.graphics.setColor(1, 1, 1, 1)
  end

  push:finish()
end

function love.keypressed(key)
  -- Load the keypressed function for the state we're in
  if states[current_state] ~= nil then
    states[current_state]:keypressed(key)
  end
end
