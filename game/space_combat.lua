local space_combat = {
  music_playing = false,
}

-- Space combat state
function space_combat:update(dt)

  -- Load main ship
  if (not ship.is_loaded) then
  	ship.load()
  end

  ship.update_movement()
end

function space_combat:draw()
  ship.render()
end

return space_combat