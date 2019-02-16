local space_combat = {
  music_playing = false,
}

-- Space combat state
function space_combat:update(dt)
  -- Start the music
  if not ship["music_playing"] then
    music["pensive"]:setLooping(true)
    music["pensive"]:play()

    title_menu["music_playing"] = true
  end

  -- Load main ship
  if (not ship.is_loaded) then
  	ship.load()
  end
  if (not enemies.is_loaded) then
    enemies.load()
  end
  if (not projectiles.is_loaded) then
    projectiles.load()
  end

  ship.update(dt)
  enemies.update(dt)
  projectiles.update(dt)
end

function space_combat:draw()
  ship.draw()
  enemies.draw()
  projectiles.draw()
end

function space_combat:keypressed(key)
end

return space_combat
