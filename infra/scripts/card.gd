extends Control

var dragging = false
var drag_offset = Vector2.ZERO

@export var title = "Card Title"

@export var body = "card body. 67 is so funny lmao"

func _ready() -> void:
	($CardTitle as RichTextLabel).text = title
	($CardBody as RichTextLabel).text = body

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				drag_offset = get_global_mouse_position() - global_position
			else:
				dragging = false

func _process(_delta):
	if dragging:
		global_position = get_global_mouse_position() - drag_offset
