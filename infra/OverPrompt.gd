extends Panel

@onready var gm: GameManager = owner


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func win():
	$Label.text = "you win!"
	$Label2.text = "nice job! you earned $%d over %d turns." % [gm.cash, (gm.total_days - gm.days_left)]
	
	visible = true
	
func lose():
	$Label.text = "you lost :("
	$Label2.text = "dang it! you earned $%d over %d turns." % [gm.cash, (gm.total_days - gm.days_left)]
	
	visible = true


func _on_keep_pressed() -> void:
	gm.infinite = true
	visible = false


func _on_replay_pressed() -> void:
	get_tree().reload_current_scene()
