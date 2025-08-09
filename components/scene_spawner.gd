class_name SceneSpawner
extends Node

@export var scene: PackedScene

# consider - instead of export packedscene, can export array of packed scenes
# and choose randomly IE enemy or powerup list

func spawn_scene(parent: Node = owner) -> Node:
    var new_scene := scene.instantiate()
    parent.add_child(new_scene)

    return new_scene
