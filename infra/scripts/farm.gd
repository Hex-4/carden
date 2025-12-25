extends TileMapLayer
class_name Farm

@onready var gm: GameManager = owner

var tiles: Array[CropTile] = [
	CropTile.new(),
	CropTile.new(),
	CropTile.new(),
	CropTile.new(),
	CropTile.new(),
	CropTile.new(),
	CropTile.new(),
	CropTile.new(),
]

var coords_to_tiles = [
	Vector2(0, 0),
	Vector2(1, 0),
	Vector2(2, 0),
	Vector2(3, 0),
	Vector2(0, 1),
	Vector2(1, 1),
	Vector2(2, 1),
	Vector2(3, 1),
]

func is_crop_empty(crop: CropTile):
	if crop.is_empty:
		return true
	else:
		return false
		

		
func has_space() -> bool:
	var empty_idx = tiles.find_custom(is_crop_empty.bind())
	
	if empty_idx == -1:
		return false
	else:
		return true
		
func has_crops() -> bool:
	var is_crop_occupied = func(crop): return !is_crop_empty(crop)
	return tiles.any(is_crop_occupied.bind())
	
func has_mature_crops() -> bool:
	var is_crop_mature = func(crop: CropTile):
		return (!crop.is_empty) and crop.turns_remaining == 0
	return tiles.any(is_crop_mature.bind())
	
func get_growth_stage(turns_remaining: int, max_turns: int) -> int:
	if turns_remaining == 0:
		return 3
	var progress = 1.0 - (float(turns_remaining) / max_turns)
	return int(progress * 3)

func plant_corn():
	var empty_idx = tiles.find_custom(is_crop_empty.bind())
	var c: CropTile = tiles[empty_idx]
	
	c.crop_type = "corn"
	c.is_empty = false
	c.planted_by = CardLib.corn_card()
	c.turns_remaining = 3
	c.max_turns = 3
	c.atlas_id = 0
	c.sells_for = 10
	
	set_cell(coords_to_tiles[empty_idx], 0, Vector2(0, 0))
	
func plant_radish():
	var empty_idx = tiles.find_custom(is_crop_empty.bind())
	var c: CropTile = tiles[empty_idx]
	
	c.crop_type = "radish"
	c.is_empty = false
	c.planted_by = CardLib.corn_card()
	c.turns_remaining = 1
	c.max_turns = 1
	c.atlas_id = 1
	c.sells_for = 3
	
	set_cell(coords_to_tiles[empty_idx], 1, Vector2(0, 0))

func plant_wheat():
	var empty_idx = tiles.find_custom(is_crop_empty.bind())
	var c: CropTile = tiles[empty_idx]
	
	c.crop_type = "wheat"
	c.is_empty = false
	c.planted_by = CardLib.corn_card()
	c.turns_remaining = 2
	c.max_turns = 2
	c.atlas_id = 2
	c.sells_for = 7
	
	set_cell(coords_to_tiles[empty_idx], 2, Vector2(0, 0))
	
func update_board():
	for tile_idx in tiles.size():
		var tile = tiles[tile_idx]
		if not tile.is_empty:
			tile.turns_remaining -= 1
			tile.turns_remaining = max(0, tile.turns_remaining) # can't go below 0
			
			var stage = get_growth_stage(tile.turns_remaining, tile.max_turns)
			
			set_cell(coords_to_tiles[tile_idx], tile.atlas_id, Vector2(stage, 0))
		

func harvest() -> int:
	var cash_this_harvest: int = 0
	for tile_idx in tiles.size():
		var tile = tiles[tile_idx]
		if not tile.is_empty and tile.turns_remaining == 0:
			cash_this_harvest += tile.sells_for
			tile.reset()
			if gm.market_count >= 0:
				gm.market_count += 1
			erase_cell(coords_to_tiles[tile_idx])
	return cash_this_harvest
