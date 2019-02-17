local enemies = {
  is_loaded = false,
  shot_error = 0.4,
  images = {"media/img/enemy1.png", "media/img/enemy2.png"},
  shot_delay = {1, 10,},
  speed = {1, 1,},

}

function enemies.load()
  enemies.init()
  enemies.enemy_init(700,200,1)
  enemies.enemy_init(600,400,2)
  --enemies.enemy_init(500,500)
  --enemies.enemy_init(300,100)
  enemies.is_loaded = true
end

function enemies.init()
  enemy_ships = {}
end

function enemies.update(dt)
  for i, enemy in ipairs(enemy_ships) do

    local diff_x = (ship.xposition - enemy.x)
    local diff_y = (ship.yposition - enemy.y)
    local rotation_to_ship = math.atan(diff_y/diff_x)
    if diff_x < 0 then
      rotation_to_ship = rotation_to_ship + math.pi
    end
    enemy.rotation = rotation_to_ship

    enemy.last_shot = enemy.last_shot + dt
    if enemy.last_shot > enemy.shot_delay then
      enemies.shoot(enemy, rotation_to_ship)
      enemy.last_shot = 0
    end
  end



end

function enemies.shoot(enemy, rotation_to_ship)
  if(enemy.e_type == 1) then
    local shot_speed = projectiles.p_speed[enemy.e_type]
    local rotation_from_ship = (rotation_to_ship+math.pi) - ship.rotation
    local new_rotation
    nextx = ship.xposition + (math.cos(ship.rotation) * ship.up_speed_scale)
    nexty = ship.yposition + (math.sin(ship.rotation) * ship.up_speed_scale)
    if (general.valid_position(nextx, nexty) and ship.moving) then
      new_rotation = math.asin(ship.up_speed_scale * (math.sin(rotation_from_ship)/shot_speed)) + rotation_to_ship
    else
      new_rotation = rotation_to_ship
    end

    local cannon_x = enemy.x + enemy.width/2 * math.cos(rotation_to_ship)
    local cannon_y = enemy.y + enemy.width/2 * math.sin(rotation_to_ship)
    projectiles.projectile_init(cannon_x, cannon_y, new_rotation, enemy.e_type)

  elseif(enemy.e_type == 2) then
    projectiles.projectile_init(enemy.x, enemy.y, rotation_to_ship, enemy.e_type)
  end
end

function enemies.get_hit_box(enemy_index)
  --if statement depending on which enemy
end

function enemies.enemy_init(x, y, e_type)
  enemy_ship = {}
  enemy_ship.x = x
  enemy_ship.y = y
  enemy_ship.rotation = math.pi
  enemy_ship.e_type = e_type
  local img_file = enemies.images[enemy_ship.e_type]
  enemy_ship.sprite = love.graphics.newImage(img_file)
  enemy_ship.width = enemy_ship.sprite:getWidth()
  enemy_ship.height = enemy_ship.sprite:getHeight()

  if(e_type == 1) then
    --regular laser ships
    enemy_ship.speed = enemies.speed[e_type]
    enemy_ship.shot_delay = enemies.shot_delay[e_type]
    enemy_ship.last_shot = 0
  elseif(e_type == 2) then
    --missile ships
    enemy_ship.speed = enemies.speed[e_type]
    enemy_ship.shot_delay = enemies.shot_delay[e_type]
    enemy_ship.last_shot = 0
  end
  
  table.insert(enemy_ships, enemy_ship)


end


function enemies.draw()
  for i, enemy in ipairs(enemy_ships) do
    love.graphics.draw(enemy.sprite, enemy.x, enemy.y, enemy.rotation, 1, 1, enemy.width/2, enemy.height/2)
  end
end

return enemies
