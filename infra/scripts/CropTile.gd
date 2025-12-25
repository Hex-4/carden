extends RefCounted
class_name CropTile

var crop_type: String = ""
var turns_remaining: int = 0
var max_turns = 3
var is_empty: bool = true
var planted_by: CardData = null
var atlas_id = 0
var sells_for = 10

func reset():
	crop_type = ""
	turns_remaining = 0
	max_turns = 3
	is_empty = true
	planted_by = null
	atlas_id = 0
	sells_for = 10
