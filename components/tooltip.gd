class_name Tooltip
extends Node

@export var tool_tip_area: Area2D
@export var tool_tip_icon: TextureRect
# @export var tool_tip_data: TooltipData

# Icon on left if present
# Header, sub-header
# body of text

# add this component, add a area2D to use as tooltip area

# either edit in-editor OR add data resource to draw upon like a template

#on mouse_entered and on_mouse_exited

# func on_mouse_entered
# check if there is a tooltip, if yes return
# draw a tooltip based on data

# func on_mouse_exited
# clear tooltip