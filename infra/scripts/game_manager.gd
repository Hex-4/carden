extends Node
class_name GameManager

var base_card_scene: PackedScene = preload("res://infra/card.tscn")

@onready var hud: HUD = $Screen/HUD

@onready var hand: Hand = $Screen/Hand

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
	var hand_size: int = hand.active_cards().size()
	
	
	while hand_size < 4:
		if deck.is_empty():
			reshuffle_discard()
		if deck.is_empty():
			break
		sfx.play_card_take()
		var c = deck.pop_back()
		var result = hand.add_card_to_hand(c)
		
		await result[1].finished # get tween
		
		(result[0] as BaseCard).state = BaseCard.CardState.ACTIVE
		
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

	
func on_card_used(card: BaseCard):
	if energy >= card.data.cost and card.data.requirement.call(self):
		update_energy(energy - card.data.cost)
		sfx.play_card_use()
		card.data.effect.call(self)
		discards.append(card.data)
		card.state = BaseCard.CardState.REMOVING
		await hand.remove_card_animated(card)
		cards_played_this_turn += 1
		

func compost():
	print("STARTING COMPOST")
	var to_remove := hand.active_cards()

	for node: BaseCard in to_remove:
		if not is_instance_valid(node):
			continue
		discards.append(node.data)
		node.state = BaseCard.CardState.REMOVING
		hand.remove_card_animated(node)
	draw()

func turn_end():
	
	
	days_left -= 1
	farm.update_board()
	var has_playable_card = false
	sfx.play_next_day()
	for card_visual in hand.active_cards():
		if card_visual.data.requirement.call(self):
			has_playable_card = true
			break

	if not has_playable_card and hand.active_cards().size() >= 4:
		await compost()
	else:
		await draw()

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
