local enemies = {
  health_bar_width = 20,
  health_bar_height = 5,
  space_between_bar = 5,
  is_loaded = false,
  shot_error = 0.4,
  images = {"media/img/enemy1.png", "media/img/enemy2.png"},
  shot_delay = {2, 10,},
  speed = {1, 1,},
  max_health = {50, 50,},

}

function enemies.load(stage)
  enemies.init()
  local planet_leftx = planet.x - planet.width
  if stage == 'space_combat' then
    for i = 1, space_combat.num_laser_ships do
      rand_x = planet_leftx - math.random()*planet_leftx/2
      rand_y = math.random() * GAME_HEIGHT
      for i, enemy in ipairs(enemy_ships) do
        while enemies.are_close(rand_x, rand_y, enemy.x, enemy.y) do
          rand_x = planet_leftx - math.random()*planet_leftx/2
          rand_y = math.random() * GAME_HEIGHT
        end
      end
      enemies.enemy_init(rand_x, rand_y, 1)
    end

    for i = 1, space_combat.num_missile_launchers do
      rand_x = planet_leftx - math.random()*planet_leftx/2
      rand_y = math.random() * GAME_HEIGHT
      for i, enemy in ipairs(enemy_ships) do
        while enemies.are_close(rand_x, rand_y, enemy.x, enemy.y) do
          rand_x = planet_leftx - math.random()*planet_leftx/2
          rand_y = math.random() * GAME_HEIGHT
        end
      end
      enemies.enemy_init(rand_x, rand_y, 2)
    end
    --enemies.enemy_init(700,200,1)
    --enemies.enemy_init(600,400,2)
    --enemies.enemy_init(500,500)
    --enemies.enemy_init(300,100)
  end
  enemies.is_loaded = true
end

function enemies.are_close(x1, y1, x2, y2)
  if(math.abs(x1-x2) < 150 and math.abs(y1-y2) < 150) then
    return true
  else
    return false
  end
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
    if enemy.last_shot > enemy.current_delay then
      enemies.shoot(enemy, rotation_to_ship)
      enemy.last_shot = 0
      enemy.current_delay = math.random()*enemy.shot_delay
    end
  end



end

function enemies.shoot(enemy, rotation_to_ship)
  if(enemy.e_type == 1) then
    local shot_speed = projectiles.p_speed[enemy.e_type]
    local rotation_from_ship = (rotation_to_ship+math.pi) - ship.rotation
    local new_rotation
    nextx = ship.xposition + (math.cos(ship.rotation) * ship.cur_speed)
    nexty = ship.yposition + (math.sin(ship.rotation) * ship.cur_speed)
    if (general.valid_position(nextx, nexty) and ship.cur_speed ~= 0) then
      new_rotation = math.asin(ship.cur_speed * (math.sin(rotation_from_ship)/shot_speed)) + rotation_to_ship
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
  --e_type == 1 are regular laser ships
  --e_type == 2 are missile ships
  enemy_ship = {}
  enemy_ship.x = x
  enemy_ship.y = y
  enemy_ship.rotation = math.pi
  enemy_ship.e_type = e_type
  local img_file = enemies.images[enemy_ship.e_type]
  enemy_ship.sprite = love.graphics.newImage(img_file)
  enemy_ship.width = enemy_ship.sprite:getWidth()
  enemy_ship.height = enemy_ship.sprite:getHeight()
  enemy_ship.max_health = enemies.max_health[e_type]
  enemy_ship.current_health = enemy_ship.max_health
  enemy_ship.speed = enemies.speed[e_type]
  enemy_ship.shot_delay = enemies.shot_delay[e_type]
  enemy_ship.current_delay = math.random()*enemy_ship.shot_delay
  enemy_ship.last_shot = 0

  table.insert(enemy_ships, enemy_ship)


end


function enemies.draw()
  for i, enemy in ipairs(enemy_ships) do
    love.graphics.draw(enemy.sprite, enemy.x, enemy.y, enemy.rotation, 1, 1, enemy.width/2, enemy.height/2)
    local left_bar = enemy.x - enemies.health_bar_width/2
    local top_bar = enemy.y + enemy.height/2 + enemies.space_between_bar
    local length_filled = enemies.health_bar_width*(enemy.current_health/enemy.max_health)
    local length_not_filled = enemies.health_bar_width-length_filled
    r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(0.0, 1.0, 0.0, 1.0)
    love.graphics.rectangle("fill", left_bar, top_bar, length_filled, enemies.health_bar_height)
    love.graphics.setColor(1.0, 0.0, 0.0, 1.0)
    love.graphics.rectangle("fill", left_bar+length_filled, top_bar, length_not_filled, enemies.health_bar_height)
    love.graphics.setColor(r, g, b, a)

  end
end

return enemies
