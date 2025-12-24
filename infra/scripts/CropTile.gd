extends RefCounted
class_name CropTile

var crop_type: String = ""
var turns_remaining: int = 0
var is_empty: bool = true
var planted_by: CardData = null

func reset():
	crop_type = ""
	turns_remaining = 0
	is_empty = true
