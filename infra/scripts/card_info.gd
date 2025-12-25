class_name CardData
extends Resource

enum TargetType {
	NONE,
	CARD_TARGET
}

var card_name: String = "Card Title"
var cost: int = 0
var description: String = "I do something! I hope!"
var needs_target: TargetType = TargetType.NONE
var effect: Callable = func(_gm): print("this should never be called but if it is getting called then that means that a test card is getting created... uuh...")
var requirement: Callable = func(gm): return true
