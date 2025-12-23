extends Control
class_name BaseCard

var dragging = false
var drag_offset = Vector2.ZERO

var title = "loading"
var body = "loading description..."
var energy_cost = 2

func setup():
	($CardTitle as RichTextLabel).text = title
	($CardBody as RichTextLabel).text = body
	$TextureRect/EnergyCost.text = str(energy_cost)
	

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
