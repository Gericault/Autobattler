class_name OutlineHighlighter
extends Node

@export var visuals: CanvasGroup
@export var outline_color: Color
@export_range(1, 10) var outline_thickness: int

func _ready() -> void:
    visuals.material.set_shader_parameter("line_colour", outline_color)
    visuals.material.set_shader_parameter("outline_thickness", outline_thickness)

func clear_highlight() -> void:
    visuals.material.set_shader_parameter("line_thickness", 0)

func highlight() -> void:
    visuals.material.set_shader_parameter("line_thickness", outline_thickness)
