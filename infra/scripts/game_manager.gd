extends Node
class_name GameManager

var base_card_scene: PackedScene = preload("res://infra/card.tscn")

@onready var energy_label = %EnergyLevel

var energy = 6

var corn_data = CardLib.corn_card()

@onready var farm: Farm = $Screen/Farm

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
