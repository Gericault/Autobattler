class_name UnitStats
extends Resource

const MOVE_ONE_TILE_SPEED := 1.0

enum Rarity {COMMON, UNCOMMON, RARE, EPIC,}
enum Team {PLAYER, ENEMY,}

const RARITY_COLOURS := {
    Rarity.COMMON: Color("5a5a5a"),
    Rarity.UNCOMMON: Color("1c527c"),
    Rarity.RARE: Color("993263"),
    Rarity.EPIC: Color("ff6f00"),
}

const TEAM_SPRITESHEET := {
    Team.PLAYER: preload("res://assets/sprites/rogues.png"),
    Team.ENEMY: preload("res://assets/sprites/monsters.png"),
}

@export var name: String

@export_category("Data")
@export var rarity: Rarity
@export var gold_cost := 1
@export_range(1, 3) var tier := 1 : set = _set_tier
@export var traits: Array[Trait]
@export var pool_count := 5

@export_category("Visuals")
# use coords because I am using a sprite sheet and only need coordinates to draw the unit
@export var skin_coordinates: Vector2i

@export_category("Battle")
@export var team: Team

# sell cost is 1:1; 3 units to combine to the power of tier - 1
# ie tier 1 (no combine) is 0. tier 2 is to the power of 1 (3x3)
# and so on
func _get_combined_unit_count() -> int:
    return 3 **(tier-1)

func _get_gold_value() -> int:
    return gold_cost * _get_combined_unit_count()

func _set_tier(value: int) -> void:
    tier = value
    emit_changed()

func _to_string() -> String:
    return name