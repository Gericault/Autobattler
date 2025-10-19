class_name PlayerStats
extends Resource

const MAX_LEVEL = 10
const XP_REQUIREMENTS := {
    1:0,
    2: 2,
    3: 2,
    4: 6,
    5: 10,
    6: 20,
    7: 36,
    8: 48,
    9: 76,
    10: 76,
}

const ROLL_RARITIES := {
    1: [UnitStats.Rarity.COMMON],
    2: [UnitStats.Rarity.COMMON],
    3: [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON],
    4: [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE],
    5: [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE],
    6: [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE],
    7: [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE, UnitStats.Rarity.EPIC],
    8: [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE, UnitStats.Rarity.EPIC],
    9: [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE, UnitStats.Rarity.EPIC],
    10:[UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE, UnitStats.Rarity.EPIC],
}

const ROLL_CHANCES := {
    1: [1],
    2: [1],
    3: [7.5, 2.5],
    4: [6.5, 3.0, 0.5],
    5: [5.0, 3.5, 1.5],
    6: [4.0, 4.0, 2.0],
    7: [2.75, 4.0, 3.24, 0.1],
    8: [2.5, 3.75, 3.45, 0.3],
    9: [1.75, 2.75, 4.5, 1.0],
    10: [1.0, 2.0, 4.5, 2.5],
}

@export_range(0, 99) var gold: int : set = _set_gold
@export_range(0, 99) var xp: int : set = _set_xp
@export_range(1, MAX_LEVEL) var level: int : set = _set_level

func get_random_rarity_for_level() -> UnitStats.Rarity:
    var rng = RandomNumberGenerator.new()
    var rarities_for_current_level: Array = ROLL_RARITIES[level]
    var weights: PackedFloat32Array = PackedFloat32Array(ROLL_CHANCES[level])
    
    #returns a rarity weighted by roll_chances const
    return rarities_for_current_level[rng.rand_weighted(weights)]

func get_current_xp_requiement() -> int:
    var next_level = clamp(level+1, 1, MAX_LEVEL)
    return XP_REQUIREMENTS[next_level]

func _set_gold(value: int) -> void:
    gold = value
    emit_changed()

func _set_xp(value: int) -> void:
    xp = value
    emit_changed()

    if is_max_level():
        return
    
    var xp_requirement: int = get_current_xp_requiement()

    # levelling is a loop in case of handling multiple level ups
    while level < MAX_LEVEL and xp >= xp_requirement:
        level += 1
        xp -= xp_requirement
        xp_requirement = get_current_xp_requiement()
        emit_changed()

func _set_level(value: int) -> void:
    level = value
    emit_changed()

func is_max_level() -> bool:
    return level == MAX_LEVEL