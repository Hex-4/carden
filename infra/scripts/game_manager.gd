extends Node
class_name GameManager

var base_card_scene: PackedScene = preload("res://infra/card.tscn")

var corn_data = CardData.new()

@onready var energy_label = %EnergyLevel

var energy = 6

func load_cards():
	corn_data.card_name = "Plant Corn"
	corn_data.description = "It's yellow! Takes 4 days to grow, sells for $6."
	corn_data.cost = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_cards()
	create_card(corn_data)
	create_card(corn_data)
	create_card(corn_data)
	create_card(corn_data)
	create_card(corn_data)
	
func update_energy(change: int):
	energy += change
	
	energy_label.text = "%02d" % energy

func create_card(data: CardData) -> BaseCard:
	var new_card: BaseCard = base_card_scene.instantiate()
	
	
	new_card.setup(data)
	$Screen/Hand.add_child(new_card)
	new_card.owner = self
	print(new_card.owner)
	return new_card

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
