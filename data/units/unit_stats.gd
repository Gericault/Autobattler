class_name UnitStats
extends Resource

enum Rarity {COMMON, UNCOMMON, RARE, EPIC,}

const RARITY_COLOURS := {
    Rarity.COMMON: Color("124a2e"),
    Rarity.UNCOMMON: Color("1c527c"),
    Rarity.RARE: Color("3b80d9"),
    Rarity.EPIC: Color("ff6f00"),
}

@export var name: String

@export_category("Data")
@export var rarity: Rarity
@export var gold_cost := 1
@export_range(1, 3) var tier := 1 : set = _set_tier

@export_category("Visuals")
# use coords because I am using a sprite sheet and only need coordinates to draw the unit
@export var skin_coordinates: Vector2i

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