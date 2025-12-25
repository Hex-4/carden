extends Control
class_name HUD

@onready var energy: RichTextLabel = $TextureRect/EnergyLevel
@onready var next_day: TextureButton = $NextDayButton
@onready var days_left: RichTextLabel = $TextureRect2/DaysLeft
@onready var cash: RichTextLabel = $TextureRect3/CurrentCash
@onready var cash_goal: RichTextLabel = $TextureRect3/GoalCash

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
