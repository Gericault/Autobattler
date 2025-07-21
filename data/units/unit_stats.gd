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

@export_category("Visuals")
# use coords because I am using a sprite sheet and only need coordinates to draw the unit
@export var skin_coordinates: Vector2i

func _to_string() -> String:
    return name