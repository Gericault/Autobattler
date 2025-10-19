class_name BattleHandler
extends Node

signal player_won
signal enemy_won

@export var game_state: GameState
@export var game_area: PlayArea
@export var game_area_unit_grid: UnitGrid
@export var battle_unit_grid: UnitGrid
@export var enemy_pool: EnemyPool
@export var enemy_formations: EnemyFormations

@onready var scene_spawner: SceneSpawner = $SceneSpawner

func _ready() -> void:
	game_state.changed.connect(_on_game_state_changed)
	enemy_pool.generate_unit_pool()

func _clean_up_fight() -> void:
	get_tree().call_group("player_units", "queue_free")
	get_tree().call_group("enemy_units", "queue_free")
	get_tree().call_group("units", "show")

func get_enemy_encounter() -> Array:
	# create enemy formation resource; increase number of enemies based on victories
	# have several formations per difficulty

	var enemy_encounter = enemy_formations.get_random_formation_for_victories(game_state.victories)
	return enemy_encounter

func _setup_battle_unit(unit_coord: Vector2i, new_unit: BattleUnit) -> void:
	new_unit.stats.reset_health()
	new_unit.stats.reset_mana()
	new_unit.global_position = game_area.get_global_from_tile(unit_coord) + Vector2(0, -Arena.QUARTER_CELL_SIZE.y)
	new_unit.tree_exited.connect(on_battle_unit_died)
	battle_unit_grid.add_unit(unit_coord, new_unit)

func on_battle_unit_died() -> void:
	#check if battle concluded or game quit
	if not get_tree() or game_state.current_phase == GameState.Phase.PREPERATION:
		return
	
	if get_tree().get_node_count_in_group("enemy_units") == 0:
		print("player won!")
		game_state.current_phase = GameState.Phase.PREPERATION
		#increment victory counter
		game_state.victories += 1
		player_won.emit()
	if get_tree().get_node_count_in_group("player_units") == 0:
		print("enemy won!")
		game_state.current_phase = GameState.Phase.PREPERATION
		game_state.victories = 0
		enemy_won.emit()

func _prepare_fight() -> void:
	get_tree().call_group("units", "hide")

	for unit_coord: Vector2i in game_area_unit_grid.get_all_occupied_tiles():
		var unit: Unit = game_area_unit_grid.units[unit_coord]
		var new_unit := scene_spawner.spawn_scene(battle_unit_grid) as BattleUnit
		new_unit.add_to_group("player_units")
		new_unit.stats = unit.stats
		new_unit.stats.team = UnitStats.Team.PLAYER
		_setup_battle_unit(unit_coord, new_unit)

	var enemy_encounter = get_enemy_encounter()

	for unit_coord: Vector2i in enemy_encounter:
		var new_unit := scene_spawner.spawn_scene(battle_unit_grid) as BattleUnit
		new_unit.add_to_group("enemy_units")
		# TODO improve this function; pass more interesting rarity selection method
		# based on victory count
		new_unit.stats = enemy_pool.get_enemy_unit_by_difficulty(UnitStats.Rarity.COMMON) 
		# spawning from enemy pool so below is redundant
		# new_unit.stats.team = UnitStats.Team.ENEMY
		_setup_battle_unit(unit_coord, new_unit)

	UnitNavigation.update_occupied_tiles()
	var battle_units := get_tree().get_nodes_in_group("player_units") + get_tree().get_nodes_in_group("enemy_units")
	battle_units.shuffle()

	for battle_unit: BattleUnit in battle_units:
		battle_unit.unit_ai.enabled = true


func _on_game_state_changed() -> void:
	match  game_state.current_phase:
		GameState.Phase.PREPERATION:
			_clean_up_fight()
		GameState.Phase.BATTLE:
			_prepare_fight()
