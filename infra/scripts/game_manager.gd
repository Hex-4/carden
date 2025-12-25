extends Node
class_name GameManager

var base_card_scene: PackedScene = preload("res://infra/card.tscn")

@onready var hud: HUD = $Screen/HUD

@onready var hand: HBoxContainer = $Screen/Hand

var energy = 3

var corn_data = CardLib.corn_card()

var cash = 0

var cash_goal = 80

@export var total_days: int = 15

var days_left: int = 1

@onready var farm: Farm = $Screen/Farm

var deck: Array[CardData] = []

var discards: Array[CardData] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deck = [
		CardLib.corn_card(),
		CardLib.corn_card(),
		CardLib.corn_card(),
		CardLib.water_card(),
		CardLib.water_card(),
		CardLib.corn_card(),
		CardLib.corn_card(),
		CardLib.corn_card(),
		CardLib.water_card(),
		CardLib.water_card(),
		CardLib.harvest_card(),
		CardLib.harvest_card(),
		CardLib.harvest_card(),
		CardLib.harvest_card(),
		
	]
	
	hud.energy.text = "%02d" % energy
	hud.days_left.text = "%02d/%02d" % [days_left, total_days]
	hud.cash.text = "%03d" % cash
	hud.cash_goal.text = "%03d" % cash_goal
	
	days_left = total_days
	
	randomize()
	deck.shuffle()
	
	draw()
	
	hud.next_day.pressed.connect(turn_end)
	
func reshuffle_discard() -> void:
	deck = discards.duplicate()
	deck.shuffle()
	discards.clear()
	
func draw() -> void:
	var hand_size: int = hand.get_child_count()
	
	while hand_size < 5:
		if deck.is_empty():
			reshuffle_discard()
		if deck.is_empty():
			break
		var c = deck.pop_back()
		add_card_to_hand(c)
		hand_size += 1
	
func update_energy(new: int):
	energy = new
	
	hud.energy.text = "%02d" % energy
	
func harvest():
	cash += farm.harvest()
	hud.cash.text = "%03d" % cash

func add_card_to_hand(data: CardData) -> BaseCard:
	var new_card: BaseCard = base_card_scene.instantiate()
	
	
	new_card.setup(data)
	$Screen/Hand.add_child(new_card)
	new_card.owner = self
	new_card.used.connect(on_card_used)
	return new_card
	
func on_card_used(card: BaseCard):
	if energy >= card.data.cost and card.data.requirement.call(self):
		update_energy(energy - card.data.cost)
		card.data.effect.call(self)
		discards.append(card.data)
		card.queue_free()
	

func turn_end():
	days_left -= 1
	farm.update_board()
	draw()
	update_energy(3)
	hud.days_left.text = "%02d/%02d" % [days_left, total_days]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
