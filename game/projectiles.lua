local projectiles = {
  is_loaded = false,
  images = {"media/img/projectile1.png", "media/img/projectile2.png",},
  p_damage = {5, 15,},
  p_speed = {10, 4},

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
  projectile.x = x
  projectile.y = y
  projectile.rotation = rotation
  projectile.p_type = p_type
  local img_file = projectiles.images[projectile.p_type]
  projectile.sprite = love.graphics.newImage(img_file)
  projectile.width = projectile.sprite:getWidth()
  projectile.height = projectile.sprite:getHeight()

  if(p_type == 1) then
    --laser
    projectile.speed = projectiles.p_speed[p_type]
    projectile.damage = projectiles.p_damage[p_type]
  elseif(p_type == 2) then
    --missile
    projectile.speed = projectiles.p_speed[p_type]
    projectile.damage = projectiles.p_damage[p_type]
  end
 
  table.insert(all_projectiles, projectile)

end

function projectiles.update()
  for i, proj in ipairs(all_projectiles) do
    if(proj.p_type == 1) then
      proj.x = proj.x + math.cos(proj.rotation)*proj.speed
      proj.y = proj.y + math.sin(proj.rotation)*proj.speed
    elseif(proj.p_type == 2) then
      local diff_x = (ship.xposition - proj.x)
      local diff_y = (ship.yposition - proj.y)
      local rotation_to_ship = math.atan(diff_y/diff_x)
      if diff_x < 0 then
        rotation_to_ship = rotation_to_ship + math.pi
      end
      proj.rotation = rotation_to_ship
      proj.x = proj.x + math.cos(proj.rotation)*proj.speed
      proj.y = proj.y + math.sin(proj.rotation)*proj.speed
    end
    if (not general.valid_position(proj.x, proj.y)) then
      table.remove(projectiles, i)
    end
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
