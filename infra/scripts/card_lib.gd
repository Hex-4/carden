class_name CardLib
extends RefCounted

static func corn_card():
	var card = CardData.new()
	card.card_name = "Plant Corn"
	card.cost = 1
	card.description = "It's yellow too! Grows in 5 days. Sells for $30."
	card.needs_target = CardData.TargetType.NONE
	card.requirement = func(gm: GameManager):
		return gm.farm.has_space()
	card.effect = func(gm: GameManager):
		gm.farm.plant_corn()
	return card
	
static func radish_card():
	var card = CardData.new()
	card.card_name = "Plant Radish"
	card.cost = 1
	card.description = "Not a dad! Grows in 1 day. Sells for $3."
	card.needs_target = CardData.TargetType.NONE
	card.requirement = func(gm: GameManager):
		return gm.farm.has_space()
	card.effect = func(gm: GameManager):
		gm.farm.plant_radish()
	return card
	
static func wheat_card():
	var card = CardData.new()
	card.card_name = "Plant Wheat"
	card.cost = 1
	card.description = "It's also yellow! Grows in 3 days. Sells for $10."
	card.needs_target = CardData.TargetType.NONE
	card.requirement = func(gm: GameManager):
		return gm.farm.has_space()
	card.effect = func(gm: GameManager):
		gm.farm.plant_wheat()
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
	
static func compost_card():
	var card = CardData.new()
	card.card_name = "Compost"
	card.cost = 0
	card.description = "Redraw your hand. The Earth says thanks!"
	card.needs_target = CardData.TargetType.NONE
	card.effect = func(gm: GameManager):
		gm.compost()
	return card
	
static func deep_water_card():
	var card = CardData.new()
	card.card_name = "Deep Water"
	card.cost = 2
	card.description = "That's a lot of water! Advance all crops by 2 turns."
	card.needs_target = CardData.TargetType.NONE
	card.requirement = func(gm: GameManager):
		return gm.farm.has_crops()
	card.effect = func(gm: GameManager):
		gm.farm.update_board()
		gm.farm.update_board()
	return card
	
static func bulk_plant_card():
	var card = CardData.new()
	card.card_name = "Bulk Plant"
	card.cost = 3
	card.description = "Fill every open tile with a radish! So this is where all of Dadish's kids are..."
	card.needs_target = CardData.TargetType.NONE
	card.requirement = func(gm: GameManager):
		return gm.farm.has_space()
	card.effect = func(gm: GameManager):
		while gm.farm.has_space():
			gm.farm.plant_radish()
	return card
	
static func market_card():
	var card = CardData.new()
	card.card_name = "Market"
	card.cost = 0
	card.description = "If 3+ crops are sold on this turn (after this card is played), get an extra $10."
	card.needs_target = CardData.TargetType.NONE
	card.effect = func(gm: GameManager):
		gm.market_count = 0
	return card
	
static func coffee_card():
	var card = CardData.new()
	card.card_name = "Coffee"
	card.cost = 1
	card.description = "Tasty! Gain +2 energy next turn."
	card.needs_target = CardData.TargetType.NONE
	card.effect = func(gm: GameManager):
		gm.coffee_energy = 2
	return card
	
static func get_starter_deck() -> Array[CardData]:
	return [
		# Fast economy
		radish_card(),
		radish_card(),
		radish_card(),
		radish_card(),
		
		# Medium crops
		wheat_card(),
		wheat_card(),
		
		# Slow payoff
		corn_card(),
		
		# Core utility
		water_card(),
		water_card(),
		harvest_card(),
		harvest_card(),
		harvest_card(),
		harvest_card(),
		
		# Spicy decision cards
		compost_card(),
		compost_card(),
		compost_card(),
		compost_card(),
		deep_water_card(),
		bulk_plant_card(),
		market_card(),
		coffee_card(),
	]
