local dialogue_generation = {
}


-- Generate a fealty announcement message
function dialogue_generation.fealty_announcement(name)
  return name ..  " announces fealty to MAGE."
end


-- Generate a death message
function dialogue_generation.fealty_announcement(name)
  return name ..  " has fallen."
end


return dialogue_generation
