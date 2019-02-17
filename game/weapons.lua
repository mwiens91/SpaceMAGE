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
    rotation = 0,

    current_health = 30,
    max_health = 30,
    cooldown = 1, -- seconds till can use again after use
    current_cooldown = 1,

    max_time_alive = 5,
    current_time_alive = 5,
  },
}

function weapons.load()

  reflector_sprite = love.graphics.newImage("media/img/reflectorfat.png")
  weapons.reflector.width = reflector_sprite:getWidth()
  weapons.reflector.height = reflector_sprite:getHeight()
  
  weapons.is_loaded = true
end

function weapons.update(dt)
  -- if the reflector's cooldown is done, can deploy can
  if weapons.reflector.current_cooldown < weapons.reflector.cooldown then
    weapons.reflector.current_cooldown = weapons.reflector.current_cooldown + dt
  else
  	weapons.reflector.can_deploy = true
  end

  -- if reflectors time on screen in up, remove reflector
  if weapons.reflector.current_time_alive < weapons.reflector.max_time_alive then
    weapons.reflector.current_time_alive = weapons.reflector.current_time_alive + dt
  else
  	weapons.reflector.deployed = false
  end

  -- if reflectors hp reachs 0, remove
  if weapons.reflector.current_health <= 0 then
  	weapons.reflector.deployed = false
  end

end

function weapons.keypressed(key)
  if key == "space" and weapons.reflector.can_deploy then
  	-- update position, start a timer to renable can_deploy, set to deployed
    xpos, ypos = ship.get_origin()

    weapons.reflector.current_time_alive = 0
    weapons.reflector.current_cooldown = 0

    weapons.reflector.rotation = ship.get_rotation()
    weapons.reflector.xposition = xpos + math.cos(weapons.reflector.rotation) * 40
    weapons.reflector.yposition = ypos + math.sin(weapons.reflector.rotation) * 40
    
    weapons.reflector.current_health = weapons.reflector.max_health

  	weapons.reflector.can_deploy = false
  	weapons.reflector.deployed = true
  end
end

function weapons.draw()
  if weapons.reflector.deployed then
    love.graphics.draw(reflector_sprite, weapons.reflector.xposition,
    	               weapons.reflector.yposition, weapons.reflector.rotation, 1, 1,
    	               weapons.reflector.width/2, weapons.reflector.height/2)

    z1,z2,z3,z4,c1,c2,c3,c4 = weapons.reflector.get_hit_box()

    love.graphics.setColor(1,1,1,.7)
    love.graphics.rectangle("fill", z1, z3, math.abs(z1-z2), math.abs(z3-z4))
    love.graphics.setColor(1,.2,.2,.7)
    love.graphics.rectangle("fill", c1, c3, math.abs(c1-c2), math.abs(c3-c4))
  end
end

function weapons.reflector.get_hit_box()
  rot = weapons.reflector.rotation
  hyp = weapons.reflector.height/2

  local lowr = rot - math.floor(rot/(math.pi*2)) * (math.pi*2)

  if lowr > math.pi then
  	lowr = lowr - math.pi
  end

  if lowr < math.pi/2 then
    leftx1 = weapons.reflector.xposition - math.abs(hyp * math.sin(rot))
    rightx1 = weapons.reflector.xposition
    leftx2 = weapons.reflector.xposition
    rightx2 = weapons.reflector.xposition + math.abs(hyp * math.sin(rot))

    topy1 = weapons.reflector.yposition
    bottomy1 = weapons.reflector.yposition + math.abs(hyp * math.cos(rot))
    topy2 = weapons.reflector.yposition - math.abs(hyp * math.cos(rot))
    bottomy2 = weapons.reflector.yposition
  elseif lowr > math.pi/2 then
    leftx1 = weapons.reflector.xposition - math.abs(hyp * math.sin(-rot))
    rightx1 = weapons.reflector.xposition
    leftx2 = weapons.reflector.xposition
    rightx2 = weapons.reflector.xposition + math.abs(hyp * math.sin(-rot))

    bottomy1 = weapons.reflector.yposition
    topy1 = weapons.reflector.yposition - math.abs(hyp * math.cos(-rot))
    bottomy2 = weapons.reflector.yposition + math.abs(hyp * math.cos(-rot))
    topy2 = weapons.reflector.yposition
  end

  return leftx1, rightx1, topy1, bottomy1, leftx2, rightx2, topy2, bottomy2
end

function weapons.reflector.got_hit(damage)
  weapons.reflector.current_health = weapons.reflector.current_health - damage
  print(string.format("Shield Remaining = %d", weapons.reflector.current_health))
end

-- Returns true if can use reflector, false otherwise
function weapons.has_reflector()
 return weapons.reflector
end

function weapons.has_stasis()
  return weapons.stasis
end

function weapons.has_emp()
  return weapons.emp
end

-- Enable or disable weapons, true to enable
function weapons.set_reflector_permit(value)
  weapons.reflector = value
end

function weapons.set_stasis_permit(value)
  weapons.stasis = value
end

function weapons.set_emp_permit(value)
 weapons.emp = value
end

return weapons