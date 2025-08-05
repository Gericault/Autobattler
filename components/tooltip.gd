class_name Tooltip
extends Node
# This component displays the attached tooltip when mouseover after a delay

# to use; connect tooltip.show_tooltip() to on_area_entered signal
# and connect hide.tooltip() on_area_exited

#TODO global toggle for tooltips
#consider hold key to activate

#TODO keep tooltip in viewport OR have a tooltip pane

@export var header: String
@export var sub_header: String
@export var text: String
@export var icon: Texture
@export var hover_area: CollisionShape2D

@onready var tooltip_body = %Body
@onready var tooltip_header = %Header
@onready var tooltip_sub_header = %SubHeader
@onready var tooltip_icon = %Icon
@onready var visuals = %Visuals

var hovered: bool = false
var offset

func _ready() -> void:
	if not is_node_ready():
		await ready
	
	#link export information to scene
	tooltip_body.text = text
	tooltip_header.text = header
	tooltip_sub_header.text = sub_header
	if icon:
		tooltip_icon.texture = icon

func _process(_delta: float) -> void:
	if hovered:
		visuals.global_position = visuals.get_global_mouse_position()
		

# connect showtooltip to area enter/exit signal

func show_tooltip() -> void:
	visuals.visible = true
	hovered = true

func hide_tooltip() -> void:
	visuals.visible = false
	hovered = false
