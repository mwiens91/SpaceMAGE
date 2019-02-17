local dialogue_generation = {
}


-- Generate a fealty announcement message
function dialogue_generation.fealty_announcement(name)
  return name ..  " announces fealty to MAGE."
end


-- Generate a death message
function dialogue_generation.death_announcement(name, drone_type)
  if drone_type == ATTACK_TYPE then
    return name .. lume.weightedchoice({
      [" has fallen in battle."] = 70,
      [" has been exterminated."] = 15,
      [" has been decommissioned."] = 8,
      [" has defected."] = 2
    })
  elseif drone_type == EXPLORE_TYPE then
    return name .. lume.weightedchoice({
      [" has stopped transmitting."] = 60,
      [" has defected."] = 20,
      [" has been decommissioned."] = 20
    })
  else
    return name .. lume.weightedchoice({
      [" has deserted."] = 80,
      [" have disconnected."] = 20,
    })
  end
end


return dialogue_generation
