local collision = {
}

function collision.check_enemy_collision(proj_index, enemy_index)
  enemy_leftx, enemy_rightx, enemy_topy, enemy_bottomy = enemies.get_hit_box(enemy_index)
  proj_leftx, proj_rightx, proj_topy, proj_bottomy = projectiles.get_hit_box(proj_index)
  cond1 = enemy_leftx <= proj_rightx
  cond2 = proj_leftx <= enemy_rightx
  cond3 = enemy_topy <= proj_bottomy
  cond4 = proj_topy <= enemy_bottomy
  if (all_projectiles[proj_index].friendly and cond1 and cond2 and cond3 and cond4) then
    enemies.got_hit(enemy_index, all_projectiles[proj_index].damage)
    table.remove(all_projectiles, proj_index)
    return true
  end
  return false

end

function collision.check_main(proj_index)
  main_leftx, main_rightx, main_topy, main_bottomy = ship.get_hit_box()
  proj_leftx, proj_rightx, proj_topy, proj_bottomy = projectiles.get_hit_box(proj_index)
  cond1 = main_leftx <= proj_rightx
  cond2 = proj_leftx <= main_rightx
  cond3 = main_topy <= proj_bottomy
  cond4 = proj_topy <= main_bottomy
  if (cond1 and cond2 and cond3 and cond4) then
    ship.got_hit(all_projectiles[proj_index].damage)
    table.remove(all_projectiles, proj_index)
    return true
  end
  return false
end

function collision.check_reflector(proj_index)
  the_proj = all_projectiles[proj_index]
  leftx1, rightx1, topy1, bottomy1, leftx2, rightx2, topy2, bottomy2 = weapons.reflector.get_hit_box()
  proj_leftx, proj_rightx, proj_topy, proj_bottomy = projectiles.get_hit_box(proj_index)
  cond1 = leftx1 <= proj_rightx
  cond2 = proj_leftx <= rightx1
  cond3 = topy1 <= proj_bottomy
  cond4 = proj_topy <= bottomy1
  cond5 = leftx2 <= proj_rightx
  cond6 = proj_leftx <= rightx2
  cond7 = topy2 <= proj_bottomy
  cond8 = proj_topy <= bottomy2
  if ((cond1 and cond2 and cond3 and cond4) or (cond5 and cond6 and cond7 and cond8)) then
    print("SHIELD HIT")
    weapons.reflector.got_hit(the_proj.damage)
    if(the_proj.p_type == 1) then
      the_proj.rotation = 2*weapons.reflector.rotation - the_proj.rotation + math.pi
    elseif(the_proj.p_type == 2) then
      table.remove(all_projectiles, proj_index)
      --projectiles.cause_explosion(the_proj.x, the_proj.y)
    end

    return true
  end
  return false
end

function collision.check_stasis(proj_index)
  the_proj = all_projectiles[proj_index]
  leftx1, rightx1, topy1, bottomy1 = weapons.stasis.get_hit_box()
  proj_leftx, proj_rightx, proj_topy, proj_bottomy = projectiles.get_hit_box(proj_index)
  cond1 = leftx1 <= proj_rightx
  cond2 = proj_leftx <= rightx1
  cond3 = topy1 <= proj_bottomy
  cond4 = proj_topy <= bottomy1
  if (cond1 and cond2 and cond3 and cond4) then
    if(the_proj.p_type == 1) then
      weapons.stasis.got_hit()
      table.remove(all_projectiles, proj_index)
    end
    return true
  end
  return false
end

function collision.collision_detection()
  proj_hit = false
  for i, proj in ipairs(all_projectiles) do
    if not proj_hit and weapons.reflector.deployed then
      proj_hit = collision.check_reflector(i)
    end
    if not proj_hit and weapons.stasis.deployed then
      proj_hit = collision.check_stasis(i)
    end
    if not proj_hit then
      proj_hit = collision.check_main(i)
    end
    for j, enemy in ipairs(enemy_ships) do
      if not proj_hit then
        proj_hit = collision.check_enemy_collision(i, j)
      end
    end
    proj_hit = false
  end
end

return collision
