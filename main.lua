-- Load external libraries
lume = require "lib.lume.lume"
push = require "lib.push.push"
suit = require "lib.suit"

-- Load up global variables
require "globals"

-- Game modules
collision = require "game.collision"
dialogue_generation = require "game.dialogue_generation"
drones = require "game.drones"
enemies = require "game.enemies"
name_generation = require "game.name_generation"
planets = require "game.planets"
prep_menu = require "game.prep_menu"
projectiles = require "game.projectiles"
ship = require "game.mainship"
space_background = require "game.space_background"
space_combat = require "game.space_combat"
title_menu = require "game.title_menu"
weapons = require "game.weapons"


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
  states["prep_menu"] = prep_menu
  states["space_combat"] = space_combat
  current_state = "title_menu"

  -- Build up a table of music tracks
  music = {}
  music["title"] = love.audio.newSource("media/audio/music/ambient01.ogg", "stream")
  music["menu"] = love.audio.newSource("media/audio/music/pensive01.ogg", "stream")
  music["space_combat"] = love.audio.newSource("media/audio/music/pensive02.ogg", "stream")

  -- Build up a table of SFX
  sfx = {}
  sfx["menu_long_01"] = love.audio.newSource("media/audio/sfx/menu_long_01.ogg", "static")
  sfx["menu_short_01"] = love.audio.newSource("media/audio/sfx/menu_short_01.ogg", "static")
  sfx["menu_short_02"] = love.audio.newSource("media/audio/sfx/menu_short_02.ogg", "static")

  -- Load the main font
  font_default = love.graphics.newFont(FONT_PATH, DEFAULT_FONT_SIZE)
  font_log = love.graphics.newFont(FONT_PATH, LOG_FONT_SIZE)
  font_menu = love.graphics.newFont(FONT_PATH, MENU_FONT_SIZE)
  font_quote = love.graphics.newFont(FONT_PATH, QUOTE_FONT_SIZE)
  font_shields = love.graphics.newFont(FONT_PATH, SHIELDS_FONT_SIZE)
  font_title = love.graphics.newFont(FONT_PATH, TITLE_FONT_SIZE)

  -- Load ship
  ship.load()

  -- Variable indicating whether to show stats on the screen
  show_side_stats = false

  -- Timer for varying drone numbers
  drone_timer = 0
  drone_cycle = 0.03

  -- Timer for updating messages
  msg_timer = 0
  msg_cycle = 0.069

  -- Seed drone counts queue and clusters
  drones.seed_drone_count_queue()
  drones.seed_drone_clusters()
end

function love.update(dt)
  -- Update drone numbers
  drone_timer = drone_timer + dt

  if drone_timer > drone_cycle then
    -- Call a function that calls a bunch more specific functions
    drones.update_drones()

    drone_timer = drone_timer - drone_cycle
  end

  -- Print messages to the drone log
  if current_state ~= "title_menu" then
    msg_timer = msg_timer + dt

    if msg_timer > msg_cycle then
      local msg = table.remove(drones["drone_backlog"], 1)

      if not (msg == nil) then
        drones.push_message(msg)
      end

    msg_timer = msg_timer - msg_cycle

    end
  end

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
      "SWARM_MORALE    " .. drones["swarm_morale"],
      10,
      55,
      GAME_WIDTH,
      "left"
    )
    love.graphics.printf(
      "SWARM_OBJECTIVE " .. drones["swarm_objective"],
      10,
      85,
      GAME_WIDTH,
      "left"
    )
    love.graphics.printf(
      "SWARM_STRATEGY  " .. drones["swarm_strategy"],
      10,
      115,
      GAME_WIDTH,
      "left"
    )
    love.graphics.printf(
      "drones_exploring " .. drones["drone_counts"]["drones_exploration"],
      10,
      GAME_HEIGHT - 300,
      GAME_WIDTH,
      "left"
    )
    love.graphics.printf(
      "drones_mining    " .. drones["drone_counts"]["drones_mining"],
      10,
      GAME_HEIGHT - 275,
      GAME_WIDTH,
      "left"
    )
    love.graphics.printf(
      "drones_attacking " .. drones["drone_counts"]["drones_attack"],
      10,
      GAME_HEIGHT - 250,
      GAME_WIDTH,
      "left"
    )

    -- Do some special formatting for the percentage change of drones
    local percentage_drone_change = drones.get_total_drone_percentage_change()
    local percentage_drone_change_str = string.format("%.1f", percentage_drone_change) .. "%"

    if percentage_drone_change >= 0 then
      percentage_drone_change_str = "+" .. percentage_drone_change_str
    end

    love.graphics.printf(
      "drones_DELTA     " .. percentage_drone_change_str,
      10,
      GAME_HEIGHT - 225,
      GAME_WIDTH,
      "left"
    )

    -- Show drone log
    love.graphics.setFont(font_log)
    love.graphics.setColor(0, 1, 0, 1)

    for idx, msg in ipairs(drones["drone_log"]) do
      love.graphics.printf(
        ">> " .. msg,
        10,
        GAME_HEIGHT - 210 + idx * 25,
        GAME_WIDTH,
        "left"
      )
    end

    -- Show shields
    love.graphics.setFont(font_shields)
    love.graphics.setColor(0, 0, 1, 1)

    local shields_percent_str = string.format(
      "%.2f",
      ship.get_current_health() / ship.get_max_health() * 100
    )

    love.graphics.printf(
      "SHIELDS:" .. shields_percent_str .. "%",
      10,
      10,
      GAME_WIDTH,
      "left"
    )

    love.graphics.setFont(font_default)
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
