local space_combat = {
  music_playing = false,
  num_laser_ships = 2,
  num_missile_launchers = 2,
  num_snipers = 1,
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
  if (not planets.is_loaded) then
    planets.load(1)
  end
  if (not ship.is_loaded) then
  	ship.load()
  end
  if (not enemies.is_loaded) then
    enemies.load('space_combat')
  end
  if (not projectiles.is_loaded) then
    projectiles.load()
  end
  if (not weapons.is_loaded) then
    weapons.load()
  end
  if (not space_background.is_loaded) then
    space_background.load()
  end

  planets.update(dt)
  ship.update(dt)
  enemies.update(dt)
  projectiles.update(dt)
  weapons.update(dt)
  collision.collision_detection()
  space_background.update(dt)
end

function space_combat:draw()
  space_background.draw()
  planets.draw()
  ship.draw()
  enemies.draw()
  projectiles.draw()
  weapons.draw()
end

function space_combat:keypressed(key)
  weapons.keypressed(key)
end

return space_combat
