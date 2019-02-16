local ship = {
	xposition = 20,
	yposition = 336,
	rotation = 0,
	up_speed_scale = 4,
	rot_speed_scale = 7,
}

function ship.load()
  ship_sprite = love.graphics.newImage("img/shiptest.png")
end

function ship.draw_ship(x, y, r)
  love.graphics.draw(ship_sprite, x, y, r, 1, 1, ship_sprite:getWidth()/2, ship_sprite:getHeight()/2)
end

function ship.render()
  ship.draw_ship(ship.xposition, ship.yposition, ship.rotation)
end

function ship.update_movement()
  
  if love.keyboard.isDown("up") then
  	xmove = math.cos(ship.rotation) * ship.up_speed_scale
    ymove = math.sin(ship.rotation) * ship.up_speed_scale

    ship.xposition = ship.xposition + xmove
    ship.yposition = ship.yposition + ymove
  end
  if love.keyboard.isDown("down") then
  	xmove = math.cos(ship.rotation) * (ship.up_speed_scale/2)
    ymove = math.sin(ship.rotation) * (ship.up_speed_scale/2)

    ship.xposition = ship.xposition - xmove
    ship.yposition = ship.yposition - ymove
  end

  if love.keyboard.isDown("left") then
    ship.rotation = ship.rotation - 0.01 * ship.rot_speed_scale
  end
  if love.keyboard.isDown("right") then
    ship.rotation = ship.rotation + 0.01 * ship.rot_speed_scale
  end
end

function love.keypressed(key)
  if (key == "q") then
  	love.event.quit()
  end
end

return ship
