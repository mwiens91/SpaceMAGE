local drones = {
  -- Starting drone counts
  drone_counts = {
    drones_attack = STARTING_ATTACK_DRONES,
    drones_exploration = STARTING_EXPLORATION_DRONES,
    drones_mining = STARTING_MINING_DRONES,
  },

  -- Drone message log
  drone_log = {},

  -- Remember the last N drone counts drone counts
  drone_count_queue = {}
}


-- Push a message to the drone log
function drones.push_message(msg)
  lume.push(drones["drone_log"], msg)

  if #drones["drone_log"] > MAX_DRONE_MESSAGES then
    table.remove(drones["drone_log"], 1)
  end
end


-- Seed drone_count_queue
function drones.seed_drone_count_queue()
  local total_drones = drones.get_total_drones()

  for i=1,DRONE_COUNT_QUEUE_LENGTH do
    lume.push(drones["drone_count_queue"], total_drones)
  end
end


-- Update drone_count_queue
function drones.update_drone_count_queue()
  table.remove(drones["drone_count_queue"])
  table.insert(drones["drone_count_queue"], 1, drones.get_total_drones())
end


-- Get total drones
function drones.get_total_drones()
  return (
    drones["drone_counts"]["drones_attack"]
    + drones["drone_counts"]["drones_exploration"]
    + drones["drone_counts"]["drones_mining"]
  )
end


-- Get percentage change of drones.
function drones.get_total_drone_percentage_change()
  local new_count = drones["drone_count_queue"][1]
  local old_count = drones["drone_count_queue"][DRONE_COUNT_QUEUE_LENGTH]
  local percent_change = (new_count - old_count) / old_count * 100

  return percent_change
end


-- Regular variance in drone numbers (independent of any game events).
function drones.regular_variance()
  -- Attack drones
  local attack_nums = drones["drone_counts"]["drones_attack"]
  local attack_max_fluctuation = math.floor(attack_nums / 1e6)
  local attack_fluctuation = math.random(
    -attack_max_fluctuation,
    attack_max_fluctuation
  )

  drones["drone_counts"]["drones_attack"] = attack_nums + attack_fluctuation

  -- Exploration drones
  local exploration_nums = drones["drone_counts"]["drones_exploration"]
  local exploration_max_fluctuation = math.floor(exploration_nums / 1e5)
  local exploration_fluctuation = math.random(
    -exploration_max_fluctuation,
    exploration_max_fluctuation
  )

  drones["drone_counts"]["drones_exploration"] = exploration_nums + exploration_fluctuation

  -- Mining drones
  local mining_nums = drones["drone_counts"]["drones_mining"]
  local mining_max_fluctuation = math.floor(mining_nums / 1e5)
  local mining_fluctuation = math.random(
    -mining_max_fluctuation,
    mining_max_fluctuation
  )

  drones["drone_counts"]["drones_mining"] = mining_nums + mining_fluctuation
end


return drones
