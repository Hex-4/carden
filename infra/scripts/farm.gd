extends TileMapLayer
class_name Farm

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

func plant_corn():
	var empty_idx = tiles.find_custom(is_crop_empty.bind())
	var c: CropTile = tiles[empty_idx]
	
	c.crop_type = "corn"
	c.is_empty = false
	c.planted_by = CardLib.corn_card()
	c.turns_remaining = 4
	
	set_cell(coords_to_tiles[empty_idx], 0, Vector2(1, 0))
