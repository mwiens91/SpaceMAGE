local projectiles = {
  is_loaded = false

}

function projectiles.load()
  projectiles.init()
  projectiles.is_loaded = true
end

function projectiles.init()
  all_projectiles = {}
end

function projectiles.projectile_init(x, y, rotation, speed)
  projectile = {}
  projectile.x = x
  projectile.y = y
  projectile.rotation = rotation
  projectile.speed = speed
  table.insert(all_projectiles, projectile)
end

function projectiles.update()
  for i, proj in ipairs(all_projectiles) do
    proj.x = proj.x + math.cos(proj.rotation)*proj.speed
    proj.y = proj.y + math.sin(proj.rotation)*proj.speed
  end
end

function projectiles.draw()
  for i, proj in ipairs(all_projectiles) do
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", proj.x, proj.y, 3, 3)
  end
end

return projectiles
