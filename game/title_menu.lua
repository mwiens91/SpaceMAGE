local title_menu = {
  music_playing = false,
}

local quote_finished = false
local quote_alpha = 1
local quote_timer = 0
local quote_time = 7.69
local help_message_show = false
local help_message_timer = 0
local help_message_time = 3.69 -- time after quote shown


-- Clean up this state and move to the next
local function exit_state()
  -- Stop the music
  music["title"]:stop()

  -- Set the next state
  current_state = "space_combat"
end


function title_menu:update(dt)
  -- Start the music
  if not title_menu["music_playing"] then
    music["title"]:setLooping(true)
    music["title"]:play()

    title_menu["music_playing"] = true
  end

  if not quote_finished then
    -- Keep the quote up for quote_time seconds
    quote_timer = quote_timer + dt

    if quote_timer > quote_time then
      if quote_alpha <= 0 then
        quote_finished = true
      else
        quote_alpha = quote_alpha - 0.069
      end
    end
  else
    -- Display a help message help_message_time seconds after the quote
    -- has gone away
    help_message_timer = help_message_timer + dt

    if help_message_timer > help_message_time then
      help_message_show = true
    end
  end
end

function title_menu:draw()
  if not quote_finished then
    -- Draw the quote
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

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(font_default)
  else
    -- Draw the title screen menu
    love.graphics.setFont(font_title)

    love.graphics.printf(
      "space_MAGE_",
      0,
      300,
      1280,
      "center"
    )

    love.graphics.setFont(font_default)

    -- Show a help message if we've been in the main menu for a bit
    if help_message_show then
      love.graphics.printf(
        "ゲームを始める ENTER",
        0,
        550,
        1280,
        "center"
      )
    end
  end
end

function title_menu:keypressed(key)
  if key == "return" and quote_finished then
    -- Play a menu sound
    sfx["menu_long_01"]:play()

    -- Leave this state
    exit_state()
  elseif key == "return" and not quote_finished then
    quote_finished = true
  end
end

return title_menu
