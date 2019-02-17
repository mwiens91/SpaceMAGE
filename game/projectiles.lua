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
  projectile.width = 10
  projectile.height = 10
  projectile.rotation = rotation
  projectile.speed = speed
  projectile.damage = 10
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
    love.graphics.rectangle("fill", proj.x, proj.y, proj.width, proj.height)
  end
end

function projectiles.get_hit_box(index)
  proj = all_projectiles[index]
  leftx = proj.x
  rightx = proj.x + proj.width
  topy = proj.y
  bottomy = proj.y + proj.height
  return leftx, rightx, topy, bottomy
end

return projectiles
