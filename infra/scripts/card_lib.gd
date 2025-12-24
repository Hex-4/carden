class_name CardLib
extends RefCounted

static func corn_card():
	var card = CardData.new()
	card.card_name = "Plant Corn"
	card.cost = 1
	card.description = "It's yellow! Grows in 4 days. Sells for $5."
	card.needs_target = CardData.TargetType.NONE
	card.effect = func(gm: GameManager):
		gm.farm.plant_corn()
	return card
