class_name CardLib
extends RefCounted

static func corn_card():
	var card = CardData.new()
	card.card_name = "Plant Corn"
	card.cost = 1
	card.description = "It's yellow! Grows in 3 days. Sells for $10."
	card.needs_target = CardData.TargetType.NONE
	card.requirement = func(gm: GameManager):
		return gm.farm.has_space()
	card.effect = func(gm: GameManager):
		gm.farm.plant_corn()
	return card

static func water_card():
	var card = CardData.new()
	card.card_name = "Sprinkler"
	card.cost = 1
	card.description = "Water everything! Advances all crops by an extra day."
	card.needs_target = CardData.TargetType.NONE
	card.requirement = func(gm: GameManager):
		return gm.farm.has_crops()
	card.effect = func(gm: GameManager):
		gm.farm.update_board()
	return card
	
static func harvest_card():
	var card = CardData.new()
	card.card_name = "Harvest All"
	card.cost = 0
	card.description = "Harvest all crops that are ready, and get some $$$!"
	card.needs_target = CardData.TargetType.NONE
	card.requirement = func(gm: GameManager):
		return gm.farm.has_mature_crops()
	card.effect = func(gm: GameManager):
		gm.harvest()
	return card
