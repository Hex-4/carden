extends Node
class_name GameManager

var base_card_scene: PackedScene = preload("res://infra/card.tscn")

var corn_info = {
	title = "Plant Corn",
	body = "It's yellow! Takes 4 days to grow, sells for $6.",
	energy = 1
}

var compost_info = {
	title = "Compost Card",
	body = "Compost this card and another of your choice. Draw 2 cards.",
	energy = 0
}

var sprinkler_info = {
	title = "Sprinkler",
	body = "It's... raining? Makes all crops grow for an extra turn.",
	energy = 1
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_card(sprinkler_info)
	create_card(corn_info)
	create_card(corn_info)
	create_card(compost_info)
	

func create_card(info: Dictionary) -> BaseCard:
	var new_card: BaseCard = base_card_scene.instantiate()
	new_card.title = info.title
	new_card.body = info.body
	new_card.energy_cost = info.energy
	new_card.setup()
	$Screen/Hand.add_child(new_card)
	return new_card

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
