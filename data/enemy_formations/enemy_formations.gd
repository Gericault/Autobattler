class_name EnemyFormations
extends Resource

# need to epand this struct, 5~ formations per victory level to choose from.
# can add another dict for each level, each with 5~ arrays
const ENEMY_FORMATIONS := {
	# 5 enemies
	0: [Vector2i(8, 1), Vector2i(7, 4), Vector2i(8, 3), ],
	1: [Vector2i(8, 1), Vector2i(7, 4), Vector2i(8, 3), Vector2i(7, 5)],
	2: [Vector2i(8, 1), Vector2i(7, 4), Vector2i(8, 3), Vector2i(9, 6), Vector2i(7, 5), Vector2i(9, 1),],
	3: [Vector2i(8, 1), Vector2i(7, 4), Vector2i(8, 3), Vector2i(9, 6), Vector2i(7, 5), Vector2i(9, 1),],
	4: [Vector2i(8, 1), Vector2i(7, 4), Vector2i(8, 3), Vector2i(9, 6), Vector2i(7, 5)],
	5: [Vector2i(8, 1), Vector2i(7, 4), Vector2i(8, 3), Vector2i(9, 6), Vector2i(7, 5)],
	6: [Vector2i(8, 1), Vector2i(7, 4), Vector2i(8, 3), Vector2i(9, 6), Vector2i(7, 5)],
	7: [Vector2i(8, 1), Vector2i(7, 4), Vector2i(8, 3), Vector2i(9, 6), Vector2i(7, 5)],
	8: [Vector2i(8, 1), Vector2i(7, 4), Vector2i(8, 3), Vector2i(9, 6), Vector2i(7, 5)],
	9: [Vector2i(8, 1), Vector2i(7, 4), Vector2i(8, 3), Vector2i(9, 6), Vector2i(7, 5)],
}

func get_random_formation_for_victories(victories) -> Array:
	# select the array for current level of victory
	var formations_for_current_victories: Array = ENEMY_FORMATIONS[victories]
	
	#TODO choose from random formation for current level of victory
	
	# return a formation
	return formations_for_current_victories
