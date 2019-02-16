lume = require "lib.lume.lume"
push = require "lib.push.push"
suit = require "lib.suit"

local gameWidth, gameHeight = 1280, 720
local windowWidth, windowHeight = love.window.getDesktopDimensions()

push:setupScreen(
  gameWidth,
  gameHeight,
  windowWidth,
  windowHeight,
  {
    fullscreen = true,
    resizable = true
  }
)

function love.load()
end

function love.update(dt)
end

function love.draw()
  push:start()

  love.graphics.print("HKLSDFKLDF", 1200, 700)

  push:finish()
end
