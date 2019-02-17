--General function module
local general = {
}

-- Checks if position of coordinates exist within the game window
function general.valid_position(x, y)
  if (x > GAME_WIDTH or x < 0 or
  	  y > GAME_HEIGHT or y < 0) then
  	return false
  else
  	return true
  end
end

return general
