extends Node2D

func _ready() -> void:
	for chicken in get_tree().get_nodes_in_group("chickens"):
		chicken.connect("chicken_ready", Callable(self, "_on_chicken_ready"))
		chicken.connect("amount_of_eggs", Callable(self, "_on_amount_of_eggs"))

func _on_chicken_ready():
	print("Game: получен сигнал CHICKEN_READY")

func _on_amount_of_eggs(count):
	print("Game: получен сигнал AMOUNT_OF_EGGS =", count)
