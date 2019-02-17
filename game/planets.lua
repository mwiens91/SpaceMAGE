local planets = {
  is_loaded = false,
  images = {"media/img/planet1.png",},
  health = 100,
}

function planets.load(planet_index)
  planet = {}
  if(planet_index) == 1 then
    planet.index = 1
    planet.x = SCROLL_WIDTH
    planet.y = GAME_HEIGHT/2
    local img_file = planets.images[planet.index]
    planet.sprite = love.graphics.newImage(img_file)
    planet.width = planet.sprite:getWidth()
    planet.height = planet.sprite:getHeight()
    planets.is_loaded = true
  end
end

function planets.get_origin(planet)
  return planet.x, planet.y
end

function planets.draw()
  love.graphics.draw(planet.sprite, planet.x, planet.y, 0, 1, 1, planet.width/2, planet.height/2)
end


function planets.update(dt)
  planet.x = planet.x - SCROLLING_SPEED
  if planet.x <= GAME_WIDTH then
    planet.x = GAME_WIDTH
    SCROLLING_SPEED = 0
  end
end

return planets
