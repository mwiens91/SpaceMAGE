local collision = {
}

function collision.check_enemy_collision(proj, ship)
end

function collision.check_main_collision(proj_index)
  --print(ship.get_hit_box())
  --print(projectiles.get_hit_box(proj_index))
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

function collision.collision_detection()
  for i, proj in ipairs(all_projectiles) do
    collision.check_main_collision(i)
    for j, enemy in ipairs(enemy_ships) do
      --check_enemy_collision(proj, enemy)
    end
  end
end

return collision
