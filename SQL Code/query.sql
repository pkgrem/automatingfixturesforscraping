select e.first_name, e.second_name,  e.points_per_game, e.selected_by_percent,  p.position, t.name, e.* from Elements e
left join Teams t on t.id = e.team_code
left join position p on p.id = e.element_type;