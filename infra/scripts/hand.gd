extends Control
class_name Hand

@export var card_spacing: float = 6



var base_card_scene: PackedScene = preload("res://infra/card.tscn")

func _ready():
	arrange_cards_animated(0)
	

func remove_card_animated(card: Control):
	if not is_instance_valid(card):
		return
	# fly out animation
	var remove_tween = create_tween()
	remove_tween.tween_property(card, "position:y", card.position.y + 150, 0.3).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	remove_tween.parallel().tween_property(card, "modulate:a", 0.0, 0.2)
	
	await remove_tween.finished
	card.call_deferred("queue_free")
	arrange_cards_animated(0.4)
	

func add_card_to_hand(data: CardData) -> Array:
	var new_card: BaseCard = base_card_scene.instantiate()
	
	
	new_card.setup(data)
	new_card.scale = Vector2(0,0)
	add_child(new_card)
	new_card.owner = owner
	new_card.used.connect(owner.on_card_used)
	arrange_cards_animated(0.4)
	var t = new_card.create_tween()
	t.tween_property(new_card, "scale", Vector2(1, 1), 0.4).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	return [new_card, t]



func arrange_cards_animated(duration: float = 0.2, extra = false):
	await get_tree().process_frame
	
	var cards = get_children()
	if cards.is_empty():
		return
		
	
	var total_width = 0.0
	for card in cards:
		total_width += card.size.x
		

	if extra:
		total_width += 80
		total_width += card_spacing * max(0, cards.size() - 1 + 1)
	else:
		total_width += card_spacing * max(0, cards.size() - 1)
	
	var start_x = (size.x - total_width) / 2.0
	var current_x = start_x
	
	
	for card_idx in range(cards.size()):
		var card = cards[card_idx]
		var target_pos = Vector2(current_x, 0)
		var tween = card.create_tween()
		tween.tween_property(card, "position", target_pos, duration).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		current_x += card.size.x + card_spacing
		
func active_cards() -> Array:
	var result = []
	for c: BaseCard in get_children():
		if c.state == BaseCard.CardState.ACTIVE:
			result.append(c)
			
	return result
