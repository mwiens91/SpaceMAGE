local drones = {
  -- Starting drone counts
  drone_counts = {
    drones_attack = 2.734159e7,
    drones_exploration = 2.1231e6,
    drones_mining = 3.14159e9,
  },

  -- Drone message log
  drone_log = {
    "propanemike01: GIMME MY GAT BACK",
    "propanemike01: BEFORE I GIVE YOU A HEART ATTACK",
    "propanemike01: THESE BITCHES BE WACK",
    "slowfox9: any questions ... ?",
    "booga: trash",
    "slowfox9: guys?",
    "slowfox9: in the back?",
    "booga: i show you",
  }
}


-- Regular variance in drone numbers (independent of any game events).
function drones.regular_variance()
  local attack_nums = drones["drone_counts"]["drones_attack"]
  local attack_max_fluctuation = math.floor(attack_nums / 1e6)
  local attack_fluctuation = math.random(
    -attack_max_fluctuation,
    attack_max_fluctuation
  )

  drones["drone_counts"]["drones_attack"] = attack_nums + attack_fluctuation

  local exploration_nums = drones["drone_counts"]["drones_exploration"]
  local exploration_max_fluctuation = math.floor(exploration_nums / 100)
  local exploration_fluctuation = math.random(
    -exploration_max_fluctuation,
    exploration_max_fluctuation
  )

  drones["drone_counts"]["drones_exploration"] = exploration_nums + exploration_fluctuation

  local mining_nums = drones["drone_counts"]["drones_mining"]
  local mining_max_fluctuation = math.floor(mining_nums / 100)
  local mining_fluctuation = math.random(
    -mining_max_fluctuation,
    mining_max_fluctuation
  )

  drones["drone_counts"]["drones_mining"] = mining_nums + mining_fluctuation
end


return drones
