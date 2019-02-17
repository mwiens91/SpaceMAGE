local ship = {
  is_loaded = false,
  start_new_level = true,
  start_main_menu = true,

  xposition = 30,
  yposition = GAME_HEIGHT/2,
  rotation = 0,
  moving = false,

  up_speed_scale = 4,
  rot_speed_scale = 7,

  cur_speed = 0,

  width = 0,
  height = 0,

  current_health = 103,
  max_health = 103,

  health_timer = 0,
  health_regen = 1, -- health regenerated / second

  current_heat = 0,
  max_heat = 40,

  heat_timer = 0,
  heat_cycle = 1,
}

function ship.get_origin()
  return ship.xposition, ship.yposition
end

function ship.load()
  ship_sprite = love.graphics.newImage("media/img/ship.png")
  ship.width = ship_sprite:getWidth()
  ship.height = ship_sprite:getHeight()
  
  ship.is_loaded = true
end

function ship.draw_ship(x, y, r)
  love.graphics.draw(ship_sprite, x, y, r, 1, 1, ship.width/2, ship.height/2)
end

function ship.draw()
  ship.draw_ship(ship.xposition, ship.yposition, ship.rotation)
end


-- Updates the ships movement based on key pressed
function ship.update(dt)
  -- Scrolling
  if current_state == "space_combat" then
    ship.update_position()
  end

  -- Regnerate health per second
  ship.health_timer = ship.health_timer + dt
  if ship.health_timer > 1 then
  	ship.health_timer = 0
  	if (ship.current_health + ship.health_regen) <= ship.max_health then
      ship.current_health = (ship.current_health + ship.health_regen)
    else
      ship.current_health = ship.max_health
    end
  end

  -- Cooldown your ship
  ship.heat_timer = ship.heat_timer + dt
  if ship.heat_timer > ship.heat_cycle then
  	ship.heat_timer = 0
  	local heat_drop = ship.max_heat / 10
  	if ship.current_heat - heat_drop < 0 then
  	  ship.current_heat = 0
  	else
      ship.current_heat = ship.current_heat - heat_drop
    end
  end

  if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
    ship.moving = true
    if ship.cur_speed < ship.up_speed_scale then
      ship.cur_speed = ship.cur_speed + 0.1
    end
    newx = ship.xposition + (math.cos(ship.rotation) * ship.cur_speed)
    newy = ship.yposition + (math.sin(ship.rotation) * ship.cur_speed)
    if (general.valid_position(newx, newy)) then
      ship.xposition = newx
      ship.yposition = newy
    end
  else
  	ship.moving = false
  	if ship.cur_speed > 0 then
  	  ship.cur_speed = ship.cur_speed - 0.05
  	else
  	  ship.cur_speed = 0
  	end
    
    newx = ship.xposition + (math.cos(ship.rotation) * ship.cur_speed)
    newy = ship.yposition + (math.sin(ship.rotation) * ship.cur_speed)
    if (general.valid_position(newx, newy)) then
      ship.xposition = newx
      ship.yposition = newy
    end
  end

  if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
    ship.rotation = ship.rotation - 0.01 * ship.rot_speed_scale
  end
  if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
    ship.rotation = ship.rotation + 0.01 * ship.rot_speed_scale
  end
end

function ship.update_position(dt)
  if ship.xposition - SCROLLING_SPEED < 0 then
  	ship.xposition = 0
  else
  	ship.xposition = ship.xposition - SCROLLING_SPEED
  end
end

function ship.start_level()
  ship.xposition = 30
  ship.yposition = GAME_HEIGHT/2
  ship.rotation = 0
  ship.moving = false
  
  ship.cur_speed = 0

  ship.current_health = ship.max_health
  ship.current_heat = 0

  ship.start_new_level = false
end

function ship.start_menu()
  ship.xposition = GAME_WIDTH/2
  ship.yposition = GAME_HEIGHT/2
  ship.rotation = 0
  ship.moving = false
  
  ship.cur_speed = 0

  ship.current_health = ship.max_health
  ship.current_heat = 0

  ship.start_main_menu = false
end

-- Return top left coordinates of hitbox and width and height
function ship.get_hit_box()
  leftx = ship.xposition - ship.width/2
  rightx = ship.xposition + ship.width/2
  topy = ship.yposition - ship.height/2
  bottomy = ship.yposition + ship.height/2
  return leftx, rightx, topy, bottomy
end

-- Ship took damage from something
function ship.got_hit(damage)
  ship.current_health = ship.current_health - damage
  --print(string.format("Health Remaining = %d", ship.current_health))
end

function ship.get_rotation()
  return ship.rotation
end

function ship.get_current_health()
  return ship.current_health
end

function ship.get_max_health()
  return ship.max_health
end

function ship.get_up_speed_scale()
  return ship.up_speed_scale
end

function ship.get_rot_speed_scale()
  return ship.rot_speed_scale
end

function ship.get_health_regen()
  return ship.health_regen
end

function ship.get_current_heat()
  return ship.current_heat
end

function ship.get_max_heat()
  return ship.max_heat
end

function ship.set_current_health(value)
  ship.current_health = value
end

function ship.set_max_health(value)
  ship.max_health = value
end

function ship.set_up_speed_scale(value)
  ship.up_speed_scale = value
end

function ship.set_rot_speed_scale(value)
  ship.rot_speed_scale = value
end

function ship.set_health_regen(value)
  ship.health_regen = value
end

function ship.set_current_heat(value)
  ship.current_heat = value
end

function ship.set_max_heat(value)
  ship.max_heat = value
end

return ship
