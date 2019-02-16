local title_menu = {
  music_playing = false,
}

local quote_displayed = false
local quote_alpha = 1
local quote_timer = 0
local quote_time = 7.69


-- The title screen
function title_menu:update(dt)
  -- Start the music
  if not title_menu["music_playing"] then
    music["title"]:setLooping(true)
    music["title"]:play()

    title_menu["music_playing"] = true
  end

  -- Display the quote if necessary
  if not quote_displayed then
    -- Keep the quote up for quote_time seconds
    quote_timer = quote_timer + dt

    if quote_timer > quote_time then
      if quote_alpha == 0 then
        quote_displayed = true
      else
        quote_alpha = quote_alpha - 0.069
      end
    end
  end
end

function title_menu:draw()
  -- Draw the quote if necessary
  if not quote_displayed then
    love.graphics.setFont(font_quote)
    love.graphics.setColor(1, 1, 1, quote_alpha)

    love.graphics.printf(
      "“If one company or small group of people manages to develop god-like superintelligence, they could take over the world”",
      0,
      300,
      1280,
      "center"
    )
    love.graphics.printf(
      "— Elon Musk, 2018",
      0,
      400,
      1280,
      "center"
    )

    love.graphics.setNewFont(DEFAULT_FONT_SIZE)
  end
end

return title_menu
