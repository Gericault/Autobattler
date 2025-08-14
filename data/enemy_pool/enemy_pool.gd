class_name EnemyPool
extends Resource

@export var available_units: Array[UnitStats]

var unit_pool: Array[UnitStats]

# Called on battle handler's ready()
func generate_unit_pool() -> void:
	unit_pool = []

	for unit: UnitStats in available_units:
		for i in unit.pool_count:
			unit_pool.append(unit)

# rarity = difficulty
func get_enemy_unit_by_difficulty(rarity: UnitStats.Rarity) -> UnitStats:
	var units := unit_pool.filter(
		func(unit: UnitStats):
			return unit.rarity == rarity
	)
	if units.is_empty():
		return null

	var picked_unit: UnitStats = units.pick_random()
	
	return picked_unit