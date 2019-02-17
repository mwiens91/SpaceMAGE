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
  main_x, main_y = ship.get_origin()
  local diff_x = (main_x - enemy.x)
  local diff_y = (main_y - enemy.y)
  local diff_lastx = enemy.main_lastx - enemy.x
  local diff_lasty = enemy.main_lasty - enemy.y
  local last_rotation = math.atan(diff_lasty/diff_lastx)
  local rotation = math.atan(diff_y/diff_x)
  if diff_x < 0 then
    rotation = rotation + math.pi
  end
  if diff_lastx < 0 then
    last_rotation = last_rotation + math.pi
  end
  local new_rotation = rotation + (rotation-last_rotation)*0.5
  --rotation = rotation + rotation-last_rotation
  --rotation = rotation-enemies.shot_error/2 + math.random()*enemies.shot_error
  --projectiles.projectile_init(enemy.x, enemy.y, rotation, enemy.shot_speed)
  --projectiles.projectile_init(enemy.x, enemy.y, last_rotation, enemy.shot_speed)
  projectiles.projectile_init(enemy.x, enemy.y, new_rotation, enemy.shot_speed)
  enemy.main_lastx = main_x
  enemy.main_lasty = main_y
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
  enemy_ship.main_lastx = 30
  enemy_ship.main_lasty = GAME_HEIGHT/2
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
