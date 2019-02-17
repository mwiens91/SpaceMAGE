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
  end
end

function collision_reflector(proj_index)
  leftx1, rightx1, topy1, bottomy1, leftx2, rightx2, topy2, bottomy2 = weapons.reflector.get_hit_box()
  proj_leftx, proj_rightx, proj_topy, proj_bottomy = projectiles.get_hit_box(proj_index)
  cond1 = leftx1 <= proj_rightx
  cond2 = proj_rightx <= rightx1
  cond3 = topy1 <= proj_bottomy
  cond4 = proj_topy <= bottomy1
  cond5 = leftx2 <= proj_rightx
  cond6 = proj_rightx <= rightx2
  cond7 = topy2 <= proj_bottomy
  cond8 = proj_topy <= bottomy2
  if (cond1 and cond2 and cond3 and cond4) or (cond5 and cond6 and cond7 and con8) then
    weapons.reflector.got_hit(proj.damage)
    table.remove(all_projectiles, proj_index)
  end
end

function collision.collision_detection()
  for i, proj in ipairs(all_projectiles) do
    collision.check_main(i)
    collision.check_reflector(i)
    for j, enemy in ipairs(enemy_ships) do
      --check_enemy_collision(proj, enemy)
    end
  end
end

return collision
