extends Control
class_name BaseCard

var dragging = false
var drag_offset = Vector2.ZERO

signal used_targetless
var data: CardData
@onready var gm: GameManager = get_owner()

func setup(new_data: CardData):
	data = new_data
	($CardTitle as RichTextLabel).text = data.card_name
	($CardBody as RichTextLabel).text = data.description
	$TextureRect/EnergyCost.text = str(data.cost)
	

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				used_targetless.emit()
				owner.update_energy(-data.cost)
				data.effect.call(owner)
				


func _process(_delta):
	if dragging:
		global_position = get_global_mouse_position() - drag_offset
