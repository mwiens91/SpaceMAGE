local prep_menu = {
  music_playing = false,
}


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
end

function prep_menu:draw()
  -- Draw the title screen menu
  love.graphics.setFont(font_menu)

  love.graphics.printf(
    "command [o]",
    0,
    GAME_HEIGHT - 100,
    GAME_WIDTH - 20,
    "right"
  )
  love.graphics.printf(
    "connect [n]",
    0,
    GAME_HEIGHT - 70,
    GAME_WIDTH - 20,
    "right"
  )
  love.graphics.printf(
    "commence [m]",
    0,
    GAME_HEIGHT - 40,
    GAME_WIDTH - 20,
    "right"
  )

  love.graphics.setFont(font_default)
end

function prep_menu:keypressed(key)
  if key == "m" then
    sfx["menu_long_01"]:play()

    exit_state()
  end
end

return prep_menu
