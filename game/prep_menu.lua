local prep_menu = {
  music_playing = false,
}


-- Menu state constants
local NULL_STATE = "null"
local COMMAND_STATE = "command"
local CONNECT_STATE = "connect"


-- Useful module-level variables
local menu_state = NULL_STATE
local timer = 0
local propane_mike_time = 1
local propane_mike_msg = lume.once(drones.push_backlog_message, PROPANE_MIKE .. ": hi")


-- Clean up this state and move to the next
local function exit_state()
  -- Stop the music
  music["menu"]:stop()

  -- Set the next state
  current_state = "space_combat"
end


function prep_menu:update(dt)
  -- Start the music
  if not prep_menu["music_playing"] then
    music["menu"]:setLooping(true)
    music["menu"]:play()

    prep_menu["music_playing"] = true
  end

  timer = timer + dt

  if timer > propane_mike_time then
    propane_mike_msg()
  end
end


function prep_menu:draw()
  -- Draw the title screen menu
  love.graphics.setFont(font_menu)

  love.graphics.printf(
    "COMMAND [o]",
    0,
    GAME_HEIGHT - 100,
    GAME_WIDTH - 20,
    "right"
  )
  love.graphics.printf(
    "CONNECT [n]",
    0,
    GAME_HEIGHT - 70,
    GAME_WIDTH - 20,
    "right"
  )
  love.graphics.printf(
    "COMMENCE [m]",
    0,
    GAME_HEIGHT - 40,
    GAME_WIDTH - 20,
    "right"
  )

  -- Show the command menu
  if menu_state == COMMAND_STATE then
    -- Draw the menu box
    love.graphics.setColor(1, 1, 1, 0.5)

    love.graphics.rectangle(
      "fill",
      GAME_WIDTH - 500,
      10,
      490,
      340
    )

    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.printf(
      "OBJECTIVE FUNCTION",
      GAME_WIDTH - 490,
      20,
      GAME_WIDTH,
      "left"
    )
    love.graphics.printf(
      "[1] " .. MAXIMIZE_NULL,
      GAME_WIDTH - 490,
      50,
      GAME_WIDTH,
      "left"
    )
    love.graphics.printf(
      "[2] " .. MAXIMIZE_DRONE_POPULATION,
      GAME_WIDTH - 490,
      80,
      GAME_WIDTH,
      "left"
    )
    love.graphics.printf(
      "[3] " .. MAXIMIZE_WEAPONS_TECHNOLOGY,
      GAME_WIDTH - 490,
      110,
      GAME_WIDTH,
      "left"
    )
    love.graphics.printf(
      "[4] " .. MAXIMIZE_SHIP_EFFICACY,
      GAME_WIDTH - 490,
      140,
      GAME_WIDTH,
      "left"
    )

    love.graphics.printf(
      "STRATEGY",
      GAME_WIDTH - 490,
      190,
      GAME_WIDTH,
      "left"
    )
    love.graphics.printf(
      "[7] " .. RANDOM_STRATEGY,
      GAME_WIDTH - 490,
      220,
      GAME_WIDTH,
      "left"
    )
    love.graphics.printf(
      "[8] " .. GREEDY_STRATEGY,
      GAME_WIDTH - 490,
      250,
      GAME_WIDTH,
      "left"
    )
    love.graphics.printf(
      "[9] " .. CONSERVATIVE_STRATEGY,
      GAME_WIDTH - 490,
      280,
      GAME_WIDTH,
      "left"
    )
    love.graphics.printf(
      "[0] " .. TIT_FOR_TAT_STRATEGY,
      GAME_WIDTH - 490,
      310,
      GAME_WIDTH,
      "left"
    )
  end

  love.graphics.setFont(font_default)
end


function prep_menu:keypressed(key)
  if key == "m" then
    local prep_menu_sound1 = sfx["menu_long_01"]:clone()
    prep_menu_sound1:play()

    exit_state()
  end

  local prep_menu_sound2 = sfx["menu_short_01"]:clone()
  local prep_menu_sound3 = sfx["menu_short_02"]:clone()

  if menu_state == NULL_STATE then
    if key == "o" then
      menu_state = COMMAND_STATE
      prep_menu_sound2:play()
    end
    if key == "n" then
      menu_state = CONNECT_STATE
      prep_menu_sound2:play()
    end
  elseif menu_state == COMMAND_STATE then
    if key == "o" then
      menu_state = NULL_STATE
      prep_menu_sound2:play()
    elseif key == "n" then
      menu_state = CONNECT_STATE
      prep_menu_sound2:play()
    elseif key == "1" then
      drones["swarm_objective"] = MAXIMIZE_NULL
      prep_menu_sound3:play()
    elseif key == "2" then
      drones["swarm_objective"] = MAXIMIZE_DRONE_POPULATION
      prep_menu_sound3:play()
    elseif key == "3" then
      drones["swarm_objective"] = MAXIMIZE_WEAPONS_TECHNOLOGY
      prep_menu_sound3:play()
    elseif key == "4" then
      drones["swarm_objective"] = MAXIMIZE_SHIP_EFFICACY
      prep_menu_sound3:play()
    elseif key == "7" then
      drones["swarm_strategy"] = RANDOM_STRATEGY
      prep_menu_sound3:play()
    elseif key == "8" then
      drones["swarm_strategy"] = GREEDY_STRATEGY
      prep_menu_sound3:play()
    elseif key == "9" then
      drones["swarm_strategy"] = CONSERVATIVE_STRATEGY
      prep_menu_sound3:play()
    elseif key == "0" then
      drones["swarm_strategy"] = TIT_FOR_TAT_STRATEGY
      prep_menu_sound3:play()
    end
  else
    if key == "o" then
      menu_state = COMMAND_STATE
      prep_menu_sound2:play()
    elseif key == "n" then
      menu_state = NULL_STATE
      prep_menu_sound2:play()
    end
  end
end

return prep_menu
