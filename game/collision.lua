local collision = {
}

function collision.check_enemy_collision(proj, ship)
end

function collision.check_main(proj_index)
  main_leftx, main_rightx, main_topy, main_bottomy = ship.get_hit_box()
  proj_leftx, proj_rightx, proj_topy, proj_bottomy = projectiles.get_hit_box(proj_index)
  cond1 = main_leftx <= proj_rightx
  cond2 = proj_leftx <= main_rightx
  cond3 = main_topy <= proj_bottomy
  cond4 = proj_topy <= main_bottomy
  if (cond1 and cond2 and cond3 and cond4) then
    ship.got_hit(proj.damage)
    table.remove(all_projectiles, proj_index)
    return true
  end
  return false
end

function collision.check_reflector(proj_index)
  leftx1, rightx1, topy1, bottomy1, leftx2, rightx2, topy2, bottomy2 = weapons.reflector.get_hit_box()
  --print(weapons.reflector.get_hit_box())
  proj_leftx, proj_rightx, proj_topy, proj_bottomy = projectiles.get_hit_box(proj_index)
  --print(projectiles.get_hit_box(proj_index))
  cond1 = leftx1 <= proj_rightx
  --print(string.format("cond1 = %s",cond1))
  cond2 = proj_leftx <= rightx1
  --print(string.format("cond2 = %s",cond2))
  cond3 = topy1 <= proj_bottomy
  --print(string.format("cond3 = %s",cond3))
  cond4 = proj_topy <= bottomy1
  --print(string.format("cond4 = %s",cond4))
  cond5 = leftx2 <= proj_rightx
  --print(string.format("cond5 = %s",cond5))
  cond6 = proj_leftx <= rightx2
  --print(string.format("cond6 = %s",cond6))
  cond7 = topy2 <= proj_bottomy
  --print(string.format("cond7 = %s",cond7))
  cond8 = proj_topy <= bottomy2
  --print(string.format("cond8 = %s",cond8))
  if ((cond1 and cond2 and cond3 and cond4) or (cond5 and cond6 and cond7 and cond8)) then
    --print("SHIELD HIT")
    weapons.reflector.got_hit(proj.damage)
    table.remove(all_projectiles, proj_index)
    return true
  end
  return false
end

function collision.collision_detection()
  proj_hit = false
  for i, proj in ipairs(all_projectiles) do
    if not proj_hit then
      proj_hit = collision.check_main(i)
    end
    if not proj_hit then
      if weapons.reflector.deployed then
        proj_hit = collision.check_reflector(i)
      end
    end
    for j, enemy in ipairs(enemy_ships) do
      --if not proj_hit then
      --check_enemy_collision(proj, enemy)
    end
    proj_hit = false
  end
end

return collision
