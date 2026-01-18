extends AudioStreamPlayer
class_name SFX

var card_use: AudioStreamWAV = preload("uid://b6yeni8cmx2bj")
var card_take: AudioStreamWAV = preload("uid://d2jdt3j44v2t6")
var lose: AudioStreamWAV = preload("uid://bihmrku03vthc")
var next_day: AudioStreamWAV = preload("uid://0twt7mf15j78")
var win: AudioStreamWAV = preload("uid://cdtstmljv8nhi")
var coins: AudioStreamWAV = preload("uid://dxca1vq44kyxm")

func play_card_use():
	pitch_scale = randf_range(0.8, 1.2)
	stream = card_use
	play(0.34)
	
func play_card_take():
	pitch_scale = randf_range(0.8, 1.2)
	stream = card_take
	play(0.32)
	
func play_lose():
	pitch_scale = 1.0
	stream = lose
	play()

func play_next_day():
	pitch_scale = 1.0
	stream = next_day
	play()
	
func play_win():
	pitch_scale = 1.0
	stream = win
	play()
	
func play_coins():
	pitch_scale = 1.0
	stream = coins
	play()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
