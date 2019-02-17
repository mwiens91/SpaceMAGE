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
  love.graphics.setFont(font_title)

  love.graphics.printf(
    "space_MAGE_",
    0,
    300,
    1280,
    "center"
  )
  love.graphics.printf(
    "IMA MENU",
    0,
    450,
    1280,
    "center"
  )

  love.graphics.setFont(font_default)
end

function prep_menu:keypressed(key)
  if key == "return" then
    -- Play a menu sound
    sfx["menu_long_01"]:play()

    exit_state()
  end
end

return prep_menu
