local projectiles = {
  is_loaded = false,
  images = {"media/img/projectile1.png",},
  p_damage = {10,},
  p_speed = {10,},

}

function projectiles.load()
  projectiles.init()
  projectiles.is_loaded = true
end

function projectiles.init()
  all_projectiles = {}
end

function projectiles.projectile_init(x, y, rotation, p_type)
  projectile = {}
  if(p_type) == 1 then
    projectile.x = x
    projectile.y = y
    projectile.rotation = rotation
    projectile.p_type = 1
    projectile.speed = projectiles.p_speed[p_type]
    projectile.damage = projectiles.p_damage[p_type]
    local img_file = projectiles.images[projectile.p_type]
    projectile.sprite = love.graphics.newImage(img_file)
    projectile.width = projectile.sprite:getWidth()
    projectile.height = projectile.sprite:getHeight()
  end
 
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
    love.graphics.draw(proj.sprite, proj.x, proj.y, proj.rotation, 1, 1, proj.width/2, proj.height/2)
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
