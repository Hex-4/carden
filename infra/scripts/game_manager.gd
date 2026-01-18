extends Node
class_name GameManager

var base_card_scene: PackedScene = preload("res://infra/card.tscn")

@onready var hud: HUD = $Screen/HUD

@onready var hand: Control = $Screen/Hand

@onready var sfx: SFX = $SFX

var energy = 3

var corn_data = CardLib.corn_card()

var cash = 0

var cash_goal = 10

@export var total_days: int = 15

var days_left: int = 1

@onready var farm: Farm = $Screen/Farm

var deck: Array[CardData] = []

var discards: Array[CardData] = []

var market_count: int = -1

var coffee_energy = 0

var cards_played_this_turn = 0

@onready var panel = $Screen/Panel

var infinite = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deck = CardLib.get_starter_deck()
	
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
	
	
	while hand_size < 4:
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
	sfx.play_coins()
	cash += farm.harvest()
	hud.cash.text = "%03d" % cash
	
	if cash > cash_goal and !infinite:
		sfx.play_win()
		panel.win()

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
		sfx.play_card_use()
		card.data.effect.call(self)
		discards.append(card.data)
		hand.remove_card_animated(card)
		cards_played_this_turn += 1
		

func compost():
	for node in hand.get_children():
		hand.remove_child(node)
		node.queue_free()
	draw()

func turn_end():
	
	
	days_left -= 1
	farm.update_board()
	var has_playable_card = false
	sfx.play_next_day()
	for card_visual in hand.get_children():
		if card_visual.data.requirement.call(self):
			has_playable_card = true
			break

	if not has_playable_card and hand.get_child_count() > 0:
		compost()
	draw()
	update_energy(3)
	if coffee_energy > 0:
		update_energy(energy + coffee_energy)
		coffee_energy = 0
	if market_count >= 3:
		cash += 10
		hud.cash.text = "%03d" % cash
	hud.days_left.text = "%02d/%02d" % [days_left, total_days]
	if infinite:
		hud.days_left.text = "%02d" % days_left
	cards_played_this_turn = 0
	market_count = -1
	
	if !infinite:
		if cash > cash_goal:
			sfx.stop()
			sfx.play_win()
			panel.win()
			
		
		if days_left < 1:
			sfx.stop()
			sfx.play_lose()
			panel.lose()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
