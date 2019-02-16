local planets = {
  is_loaded = false,
  images = {"media/img/planet1.png",},
  health = 100,
}

function planets.load(planet_index)
  planet = {}
  if(planet_index) == 1 then
    planet.index = 1
    planet.x = GAME_WIDTH
    planet.y = GAME_HEIGHT/2
    local img_file = planets.images[planet.index]
    planet_sprite = love.graphics.newImage(img_file)
    --planet_sprite = love.graphics.newImage("media/img/planet1.png")
    planet.width = planet_sprite:getWidth()
    planet.height = planet_sprite:getHeight()
    planets.is_loaded = true
  end
end

function planets.get_origin(planet)
  return planet.x, planet.y
end

function planets.draw()
  love.graphics.draw(planet_sprite, planet.x, planet.y, 0, 1, 1, planet.width/2, planet.height/2)
end


function planets.update(dt)
  --if planet ever needs updating (e.g. exploding...)
end

return planets
