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
end

return title_menu
