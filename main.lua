lume = require "lib.lume.lume"
push = require "lib.push.push"
suit = require "lib.suit"

function love.load()
  -- Setup screen resolution and upscaling with push
  local window_width, window_height = love.window.getDesktopDimensions()

  push:setupScreen(
    GAME_WIDTH,
    GAME_HEIGHT,
    window_width,
    window_height,
    {
      fullscreen = true,
    }
  )

  -- Other setup here
end

function love.update(dt)
end

function love.draw()
  push:start()

  love.graphics.print("HKLSDFKLDF", 1200, 700)

  push:finish()
end
