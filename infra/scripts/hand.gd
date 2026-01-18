# hand.gd
extends Control

@export var card_spacing: float = 6

func _ready():
	child_exiting_tree.connect(_on_card_removing)
	arrange_cards_animated(0)
	

func remove_card_animated(card: Control):
	# fly out animation
	var remove_tween = create_tween()
	remove_tween.tween_property(card, "position:y", card.position.y + 150, 0.3).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	remove_tween.parallel().tween_property(card, "modulate:a", 0.0, 0.2)
	
	await remove_tween.finished
	card.queue_free()

func _on_card_removing(card):
	# rearrange when card is actually removed
	arrange_cards_animated(0.4)

func arrange_cards_animated(duration: float = 0.2):
	await get_tree().process_frame
	
	var cards = get_children()
	if cards.is_empty():
		return
	
	var total_width = 0.0
	for card in cards:
		total_width += card.size.x
	total_width += card_spacing * max(0, cards.size() - 1)
	
	var start_x = (size.x - total_width) / 2.0
	var current_x = start_x
	
	for card_idx in range(cards.size()):
		var card = cards[card_idx]
		var target_pos = Vector2(current_x, 0)
		var tween = create_tween()
		tween.tween_property(card, "position", target_pos, duration).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		current_x += card.size.x + card_spacing
