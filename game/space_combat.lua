local space_combat = {
  music_playing = false,
}

-- Space combat state
function space_combat:update(dt)
  -- Start the music
  if not ship["music_playing"] then
    music["space_combat"]:setLooping(true)
    music["space_combat"]:play()

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
  if (not planets.is_loaded) then
    planets.load(1)
  end

  ship.update(dt)
  enemies.update(dt)
  projectiles.update(dt)
  planets.update(dt)
end

function space_combat:draw()
  ship.draw()
  enemies.draw()
  projectiles.draw()
  planets.draw()
end

function space_combat:keypressed(key)
end

return space_combat
