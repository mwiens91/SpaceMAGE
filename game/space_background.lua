local space_background = {
  is_loaded = false,
  asteroids = {},

  asteroid_time = 0,
  asteroid_cycle = 0.1,
}

function space_background.asteroid_init()
  asteroid = {}
  asteroid.width = asteroid_sprite:getWidth()
  asteroid.height = asteroid_sprite:getHeight()
  asteroid.xposition = GAME_WIDTH
  asteroid.yposition = math.random(50, GAME_HEIGHT)
  asteroid.rotation = math.random(160, 200) * (math.pi/180)
  asteroid.speed = math.random(8,18)
  asteroid.scale = math.random(5, 30) / 10

  table.insert(space_background.asteroids, asteroid)
end


function space_background.load()
  asteroid_sprite = love.graphics.newImage("media/img/asteroid.png")
  
  space_background.is_loaded = true
end

function space_background.update(dt)
 -- if is loaded, randomly create asteroids
  if space_background.is_loaded then
  	space_background.asteroid_time = space_background.asteroid_time + dt

  	if space_background.asteroid_time > space_background.asteroid_cycle then
      local randgen1 = math.random(1,4)
      if math.random(1, 4) == 1 then
        space_background.asteroid_init()
        if math.random(1, 4) == 1 then
        	space_background.asteroid_init()
        end
      end
      space_background.asteroid_time = 0
    end
  end

  for i, rock in ipairs(space_background.asteroids) do
    rock.xposition = rock.xposition + math.cos(rock.rotation) * rock.speed
    rock.yposition = rock.yposition + math.sin(rock.rotation) * rock.speed

    if rock.xposition < 0 or rock.xposition > GAME_WIDTH or
       rock.yposition < 0 or rock.yposition > GAME_HEIGHT then
      table.remove(space_background.asteroids, i)
    end
  end
end

function space_background.draw()
  -- draw all asteroids in table
  for i, rock in ipairs(space_background.asteroids) do
  	love.graphics.draw(asteroid_sprite, rock.xposition, rock.yposition, rock.rotation,
  		               rock.scale, rock.scale, rock.width/2, rock.height/2)
  end

  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(0, 0, 0, 0.8)
  love.graphics.rectangle("fill", 0, 0, GAME_WIDTH, GAME_HEIGHT)

  love.graphics.setColor(r, g, b, a)

end

return space_background