local enemies = {
  is_loaded = false,
  shot_error = 0.4

}

ENEMY_SHIP_COLOR = {1.0, 1.0, 1.0}

function enemies.load()
  enemies.init()
  enemies.enemy_init(700,300)
  --enemies.enemy_init(500,500)
  --enemies.enemy_init(300,100)
  enemies.is_loaded = true
end

function enemies.init()
  enemy_ships = {}
end

function enemies.update(dt)
  for i, enemy in ipairs(enemy_ships) do
    enemy.last_shot = enemy.last_shot + dt
    if enemy.last_shot > enemy_ship.shot_delay then
      enemies.shoot(enemy)
      enemy.last_shot = 0
    end
  end



end

function enemies.shoot(enemy)
  local diff_x = (ship.xposition - enemy.x)
  local diff_y = (ship.yposition - enemy.y)
  local rotation_to_ship = math.atan(diff_y/diff_x)
  if diff_x < 0 then
    rotation_to_ship = rotation_to_ship + math.pi
  end
  local rotation_from_ship = (rotation_to_ship+math.pi) - ship.rotation
  local new_rotation
  nextx = ship.xposition + (math.cos(ship.rotation) * ship.up_speed_scale)
  nexty = ship.yposition + (math.sin(ship.rotation) * ship.up_speed_scale)
  if (ship.valid_position(newx, newy) and ship.moving) then
    new_rotation = math.asin(ship.up_speed_scale * (math.sin(rotation_from_ship)/enemy.shot_speed)) + rotation_to_ship
  else
    new_rotation = rotation_to_ship
  end

  --rotation = rotation-enemies.shot_error/2 + math.random()*enemies.shot_error
  --projectiles.projectile_init(enemy.x, enemy.y, rotation, enemy.shot_speed)
  --projectiles.projectile_init(enemy.x, enemy.y, last_rotation, enemy.shot_speed)
  projectiles.projectile_init(enemy.x, enemy.y, new_rotation, enemy.shot_speed)
end

function enemies.enemy_init(x, y)
  enemy_ship = {}
  enemy_ship.x = x
  enemy_ship.y = y
  enemy_ship.rotation = math.pi
  enemy_ship.speed = 1
  enemy_ship.shot_speed = 10
  enemy_ship.shot_delay = 1
  enemy_ship.last_shot = 0
  table.insert(enemy_ships, enemy_ship)
end


function enemies.draw()
  --love.graphics.setColor(1,1,1)
  --love.graphics.rectangle("fill", enemy_ship.x, enemy_ship.y, 30, 30)
  for i, enemy in ipairs(enemy_ships) do
    love.graphics.setColor(ENEMY_SHIP_COLOR[1], ENEMY_SHIP_COLOR[2], ENEMY_SHIP_COLOR[3])

    love.graphics.rectangle("fill", enemy.x, enemy.y, 30, 30)
  end
end

return enemies
