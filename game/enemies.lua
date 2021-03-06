local enemies = {
  health_bar_width = 20,
  health_bar_height = 5,
  space_between_bar = 5,
  is_loaded = false,
  shot_error = 0.4,
  images = {"media/img/enemy1.png", "media/img/enemy2.png"},
  shot_delay = {2, 8,},
  speed = {1, 1,},
  max_health = {50, 50,},
  too_close = 100

}

function enemies.load(stage)
  enemies.init()
  if stage == 'space_combat' then
    for i = 1, space_combat.num_laser_ships do
      local too_close = true
      while too_close do
        too_close = false 
        rand_x = math.random(GAME_WIDTH, (planet.x - planet.width))
        rand_y = math.random(0, GAME_HEIGHT)
        for i, enemy in ipairs(enemy_ships) do
          if enemies.are_close(rand_x, rand_y, enemy.x, enemy.y) then
            too_close = true
          end
        end
      end
      enemies.enemy_init(rand_x, rand_y, 1)
    end

    for i = 1, space_combat.num_missile_launchers do
      local too_close = true
      while too_close do
        too_close = false
        rand_x = math.random(GAME_WIDTH, (planet.x - planet.width))
        rand_y = math.random(0, GAME_HEIGHT)
        for i, enemy in ipairs(enemy_ships) do
          if enemies.are_close(rand_x, rand_y, enemy.x, enemy.y) then
            too_close = true
          end
        end
      end
      enemies.enemy_init(rand_x, rand_y, 2)
    end
  end
  enemies.is_loaded = true
end

function enemies.are_close(x1, y1, x2, y2)
  x_squared = math.abs(x1-x2) * math.abs(x1-x2)
  y_squared = math.abs(y1-y2) * math.abs(y1-y2)
  distance = math.sqrt(x_squared + y_squared)
  if(distance < enemies.too_close) then
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
    enemy.x = enemy.x - SCROLLING_SPEED
    if enemy.x+enemy.width/2 <= 0 then
      table.remove(enemy_ships, i)
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
    local missile_x = enemy.x + enemy.width/2 * math.cos(rotation_to_ship)
    local missile_y = enemy.y + enemy.width/2 * math.sin(rotation_to_ship)
    projectiles.projectile_init(missile_x, missile_y, rotation_to_ship, enemy.e_type)
  end
end

function enemies.get_hit_box(enemy_index)
  enemy = enemy_ships[enemy_index]
  leftx = enemy.x - enemy.width/2
  rightx = enemy.x + enemy.width/2
  topy = enemy.y - enemy.height/2
  bottomy = enemy.y + enemy.height/2
  return leftx, rightx, topy, bottomy
end

-- Enemy ship took damage from something
function enemies.got_hit(enemy_index, damage)
  enemy = enemy_ships[enemy_index]
  enemy.current_health = enemy.current_health - damage
  if enemy.current_health <= 0 then
    enemy.current_health = 0
    table.remove(enemy_ships, enemy_index)
  end
  --print(string.format("Health Remaining = %d", enemy.current_health))
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
