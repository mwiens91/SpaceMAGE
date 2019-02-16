local space_combat = {
  music_playing = false,
}

-- Space combat state
function space_combat:update(dt)

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

  ship.update_movement()
  enemies.update(dt)
  projectiles.update(dt)
end

function space_combat:draw()
  ship.render()
  enemies.draw()
  projectiles.draw()
end

function space_combat:keypressed(key)
end

return space_combat
