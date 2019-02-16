local weapons = {
  is_loaded = false,

  reflector = true,
  stasis = false,
  emp = false,

  reflector = {
    can_deploy = true,
    deployed = false,
    width = 0,
    height = 0,

    xposition = 0,
    yposition = 0,

    health = 2,
    cooldown = 3, -- seconds till can use again after use
    current_cooldown = 3,

    max_time_alive = 2,
    current_time_alive = 2,
  },
}

function weapons.load()

  reflector_sprite = love.graphics.newImage("media/img/reflector.png")
  weapons.reflector.width = reflector_sprite:getWidth()
  weapons.reflector.height = reflector_sprite:getHeight()
  
  weapons.is_loaded = true
end

function weapons.update(dt)
  if weapons.reflector.current_cooldown < weapons.reflector.cooldown then
    weapons.reflector.current_cooldown = weapons.reflector.current_cooldown + dt
  else
  	weapons.reflector.can_deploy = true
  end

  if weapons.reflector.current_time_alive < weapons.reflector.max_time_alive then
    weapons.reflector.current_time_alive = weapons.reflector.current_time_alive + dt
  else
  	weapons.reflector.deployed = false
  end

end

function weapons.keypressed(key)
  if key == "space" and weapons.reflector.can_deploy then
  	-- update position, start a timer to renable can_deploy, set to deployed
    xpos, ypos = ship.get_origin()

    weapons.reflector.current_time_alive = 0
    weapons.reflector.current_cooldown = 0

    weapons.reflector.xposition = xpos + 20
    weapons.reflector.yposition = ypos

  	weapons.reflector.can_deploy = false
  	weapons.reflector.deployed = true
  end
end

function weapons.draw()
  if weapons.reflector.deployed then
    love.graphics.draw(reflector_sprite, weapons.reflector.xposition,
    	               weapons.reflector.yposition, 0, 1, 1,
    	               weapons.reflector.width/2, weapons.reflector.height/2)
  end
end

function weapons.draw_reflector()
end

-- Returns true if can use reflector, false otherwise
function weapons.has_reflector()
end

function weapons.has_stasis()
end

function weapons.has_emp()
end

-- Enable or disable weapons, true to enable
function weapons.set_reflector_permit(value)
end

function weapons.set_stasis_permit(value)
end

function weapons.set_emp_permit(value)
end

return weapons