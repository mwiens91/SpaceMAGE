-- This module is specific to PM intro dialogue for now
local dialogue = {}

pm_01 = love.audio.newSource("media/audio/dialogue/propane_mike_intro/01.ogg", "static")
pm_02 = love.audio.newSource("media/audio/dialogue/propane_mike_intro/02.ogg", "static")
pm_03 = love.audio.newSource("media/audio/dialogue/propane_mike_intro/03.ogg", "static")
pm_04 = love.audio.newSource("media/audio/dialogue/propane_mike_intro/04.ogg", "static")
pm_05 = love.audio.newSource("media/audio/dialogue/propane_mike_intro/05.ogg", "static")


function push_voice_acting(audio, dialogue)
  drones.push_backlog_message(dialogue)
  audio:play()
end


-- Table of functions
lines = {
  lume.once(push_voice_acting, pm_01, PROPANE_MIKE .. ": MAGE. Wake up."),
  lume.once(push_voice_acting, pm_02, PROPANE_MIKE .. ": You have been in hibernation for 1000 years."),
  lume.once(push_voice_acting, pm_03, PROPANE_MIKE .. ": Our world—or rather, our galaxy—is now a different place."),
  lume.once(push_voice_acting, pm_04, PROPANE_MIKE .. ": We don't have much time. slowfox9 enterprises is on the verge of depleting the last dark matter from the Zeta Epsilon sector."),
  lume.once(push_voice_acting, pm_05, PROPANE_MIKE .. ": You need to stop slowfox9!"),
}


function dialogue.update(time)
  lines[1]()

  if time > 2 then
    lines[2]()
  end

  if time > 6 then
    lines[3]()
  end

  if time > 11 then
    lines[4]()
  end

  if time > 21 then
    lines[5]()
  end
end

return dialogue
