extends Panel

@onready var gm: GameManager = owner


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pivot_offset = size / 2
	visible = false
	

func reveal() -> void:
	print("revealing")
	if visible == false:
		var t = create_tween()
		scale = Vector2(0,0)
		visible = true
		t.tween_property(self, "scale", Vector2(1,1), 0.4).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		
func disappear() -> void:
	print("disappearing")
	if visible == true:
		var t = create_tween()
		scale = Vector2(1, 1)
		t.tween_property(self, "scale", Vector2(0,0), 0.4).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		t.tween_property(self, "visible", false, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func win():
	$Label.text = "you win!"
	$Label2.text = "nice job! you earned $%d over %d turns." % [gm.cash, (gm.total_days - gm.days_left)]
	
	reveal()
	
func lose():
	$Label.text = "you lost :("
	$Label2.text = "dang it! you earned $%d over %d turns." % [gm.cash, (gm.total_days - gm.days_left)]
	
	reveal()


func _on_keep_pressed() -> void:
	gm.infinite = true
	disappear()


func _on_replay_pressed() -> void:
	get_tree().reload_current_scene()
