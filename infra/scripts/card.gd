extends Control
class_name BaseCard

var dragging = false
var drag_offset = Vector2.ZERO

signal used(me)
var data: CardData
@onready var gm: GameManager = get_owner()

func setup(new_data: CardData):
	data = new_data
	($CardTitle as RichTextLabel).text = data.card_name
	($CardBody as RichTextLabel).text = data.description
	$TextureRect/EnergyCost.text = str(data.cost)
	pivot_offset = size / 2
	

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				used.emit(self)


func _process(_delta):
	if dragging:
		global_position = get_global_mouse_position() - drag_offset


func _on_mouse_entered() -> void:
	var t = get_tree().create_tween()
	
	t.tween_property(self, "scale", Vector2(1.07, 1.07), 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _on_mouse_exited() -> void:
	var t = get_tree().create_tween()
	
	t.tween_property(self, "scale", Vector2(1, 1), 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
