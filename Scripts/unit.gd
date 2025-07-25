@tool
class_name Unit
extends Area2D

signal quick_sell_pressed

@export var stats: UnitStats : set = set_stats

@onready var skin: Sprite2D = %Skin
@onready var health_bar: ProgressBar = $HealthBar
@onready var mana_bar: ProgressBar = $ManaBar
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var drag_and_drop: DragAndDrop = $DragAndDrop
@onready var velocity_based_rotation: VelocityBasedRotation = $VelocityBasedRotation
@onready var out_line_highlighter: OutlineHighlighter = $OutlineHighlighter

var is_hovered := false

func _ready() -> void:
	# set collision shape equal to the size of the unit's cell
	#collision_shape.size = vector2(Arena.CELL_SIZE, Arena.CELL_SIZE)
	if not Engine.is_editor_hint():
		drag_and_drop.drag_started.connect(_on_drag_started)
		drag_and_drop.drag_canceled.connect(_on_drag_canceled)

func _input(event: InputEvent) -> void:
	if not is_hovered:
		return
	if event.is_action_pressed("quick_sell"):
		quick_sell_pressed.emit()


func set_stats(value: UnitStats) -> void:
	stats = value

	if value == null:
		return

	if not is_node_ready():
		await ready

	skin.region_rect.position = Vector2(stats.skin_coordinates) * Arena.CELL_SIZE

func _on_drag_started() -> void:
	velocity_based_rotation.enabled = true
	# consider changing highlight while dragging here

func _on_drag_canceled(starting_position: Vector2) -> void:
	reset_after_dragging(starting_position)

func reset_after_dragging(starting_position:Vector2) -> void:
	velocity_based_rotation.enabled = false
	global_position = starting_position

func _on_mouse_entered() -> void:
	# if dragging something do not highlight
	if drag_and_drop.dragging:
		return
	is_hovered = true
	out_line_highlighter.highlight()
	# ensures units don't overlap
	z_index = 1

func _on_mouse_exited() -> void:
	if drag_and_drop.dragging:
		return
	
	is_hovered = false
	out_line_highlighter.clear_highlight()
	z_index = 0
