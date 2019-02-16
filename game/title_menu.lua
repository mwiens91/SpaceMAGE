local title_menu = {
  music_playing = false,
}

-- The title screen
function title_menu:update(dt)
  -- Start the music
  if not title_menu["music_playing"] then
    music["title"]:setLooping(true)
    music["title"]:play()

    title_menu["music_playing"] = true
  end
end

function title_menu:draw()
  love.graphics.printf(
    "\"If one company or small group of people manages to develop god-like superintelligence, they could take over the world,\"",
    100,
    300,
    540,
    "center",
    0,
    2,
    2
  )

  love.graphics.printf("— Elon Musk, 2018", 600, 400, 1280, "left", 0, 2, 2)
end

return title_menu
