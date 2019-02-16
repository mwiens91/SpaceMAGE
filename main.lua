lume = require "lib.lume.lume"
push = require "lib.push.push"
suit = require "lib.suit"

function love.load()
  -- Setup screen resolution and upscaling with push
  local game_width, game_height = 1280, 720
  local window_width, window_height = love.window.getDesktopDimensions()

  push:setupScreen(
    game_width,
    game_height,
    window_width,
    window_height,
    {
      fullscreen = true,
      resizable = true
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
