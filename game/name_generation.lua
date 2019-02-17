local name_generation = {
}


local romanized_japanese_numbers = {
  "Ichi",
  "Ni",
  "San",
  "Yon",
  "Go",
  "Roku",
  "Nana",
  "Hachi",
  "Kyuu",
  "Juu",
  "Hyaku",
  "Sen",
  "Man",
  "Juuman",
  "Hyakuman",
  "Senman",
  "Ichioku",
  "Juuoku",
  "Icchou",
}


local greek_letters = {
  "Alpha",
  "Beta",
  "Gamma",
  "Delta",
  "Epsilon",
  "Zeta",
  "Eta",
  "Theta",
  "Iota",
  "Kappa",
  "Lambda",
  "Mu",
  "Nu",
  "Xi",
  "Omicron",
  "Pi",
  "Rho",
  "Sigma",
  "Tau",
  "Upsilon",
  "Phi",
  "Chi",
  "Psi",
  "Omega",
}

local phonetic_alphabet = {
  "Bravo",
  "Charlie",
  "Echo",
  "Foxtrot",
  "Golf",
  "Hotel",
  "India",
  "Juliet",
  "Kilo",
  "Lima",
  "Mike",
  "November",
  "Oscar",
  "Papa",
  "Quebec",
  "Romeo",
  "Sierra",
  "Tango",
  "Uniform",
  "Victor",
  "Whiskey",
  "X-ray",
  "Yankee",
  "Zulu",
}


function name_generation.generate_cluster_name(drone_type)
  -- Iteratively build up the drone cluster's name
  local name = ""

  if drone_type == ATTACK_TYPE then
    name = "Attack Cluster "
  elseif drone_type == EXPLORE_TYPE then
    name = "Exploration Cluster "
  else
    name = "Mining Cluster "
  end

  name = name .. lume.randomchoice(romanized_japanese_numbers) .. " "
  name = name .. lume.randomchoice(greek_letters) .. " "
  name = name .. lume.randomchoice(phonetic_alphabet)

  return name
end


return name_generation
