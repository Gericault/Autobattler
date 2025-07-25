class_name VelocityBasedRotation
extends Node

@export var enabled: bool = true : set = _set_enabled
@export var target: Node2D
@export_range(0.25, 1.5) var lerp_seconds :=0.4
#@export var rotation_multiplier :=1.2
@export var x_velocity_threshold := 5
@export var x_velocity_lower_threshold := 2
@export_range(0, 360) var max_angle := 45.0

var last_position: Vector2
var velocity: Vector2
var angle: float
var progress: float
var time_elapsed := 0.0

func _physics_process(delta: float) -> void:
    if not enabled or not target:
        return

    velocity = target.global_position - last_position
    last_position = target.global_position
    progress = time_elapsed / lerp_seconds

    if abs(velocity.x) > x_velocity_threshold:
        angle = velocity.normalized().x * deg_to_rad(max_angle)
    elif angle != 0 and abs(velocity.x) > x_velocity_lower_threshold:
        angle = velocity.normalized().x * deg_to_rad(max_angle)
    else:
        angle = 0.0

    # Limit the angle to max angle amount
    angle = clamp(angle, -max_angle, max_angle)

    target.rotation = lerp_angle(target.rotation, angle, progress)
    time_elapsed += delta
    
    if progress > 1.0:
        time_elapsed = 0.0

func _set_enabled(value: bool) -> void:
    enabled = value

    if target and enabled == false:
        target.rotation = 0.0
