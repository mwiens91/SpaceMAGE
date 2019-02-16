local ship = {
  is_loaded = false,

  xposition = 20,
  yposition = 336,
  rotation = 0,

  up_speed_scale = 4,
  rot_speed_scale = 7,

  width = 0,
  height = 0,
}

function ship.get_origin()
  return ship.xposition + ship.width/2, ship.yposition + ship.height/2
end

function ship.load()
  ship_sprite = love.graphics.newImage("media/img/shiptest.png")
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
  --print(ship.get_origin())
  if love.keyboard.isDown("up") then
    newx = ship.xposition + (math.cos(ship.rotation) * ship.up_speed_scale)
    newy = ship.yposition + (math.sin(ship.rotation) * ship.up_speed_scale)
    if (ship.valid_position(newx, newy)) then
      ship.xposition = newx
      ship.yposition = newy
    end
  end
  if love.keyboard.isDown("down") then

  	newx = ship.xposition - (math.cos(ship.rotation) * ship.up_speed_scale/2)
    newy = ship.yposition - (math.sin(ship.rotation) * ship.up_speed_scale/2)

    if (ship.valid_position(newx, newy)) then
      ship.xposition = newx
      ship.yposition = newy
    end
  end

  if love.keyboard.isDown("left") then
    ship.rotation = ship.rotation - 0.01 * ship.rot_speed_scale
  end
  if love.keyboard.isDown("right") then
    ship.rotation = ship.rotation + 0.01 * ship.rot_speed_scale
  end
end

-- Checks if position of coordinates exist within the game window
function ship.valid_position(x, y)
  if (x > GAME_WIDTH or x < 0 or
  	  y > GAME_HEIGHT or y < 0) then
  	return false
  else
  	return true
  end
end

return ship
