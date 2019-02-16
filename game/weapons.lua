local weapons = {
  is_loaded = false,

  reflector = true,
  stasis = false,
  emp = false,
  
  local reflector = {
    can_deploy = true,
    width = 0,
    height = 0,

    xposition = 0,
    yposition = 0,

    health = 2,
    cooldown = 3, -- seconds till can use again after use
  }
}

function weapons.load()
  reflector_sprite = love.graphics.newImage("media/img/reflector.png")
  weapons.reflector.width = reflector_sprite:getWidth()
  weapons.reflector.height = reflector_sprite:getHeight()
  
  weapons.is_loaded = true
end

function weapons.draw()
  if weapons.reflector.can_deploy
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
