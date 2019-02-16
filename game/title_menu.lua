local title_menu = {
  music_playing = false,
}

-- The title screen
function title_menu:update(dt)
  debug_text = "TITLE MENU"

  -- Start the music
  if not title_menu["music_playing"] then
    music["title"]:setLooping(true)
    music["title"]:play()
  end
end

return title_menu
