extends Node2D

@onready var egg_scene = preload("res://elements/characters/egg.tscn")
@onready var eggs_container = $Eggs
@onready var custom_cursor = $CustomCursor

func _ready() -> void:
	for chicken in get_tree().get_nodes_in_group("chickens"):
		chicken.connect("chicken_is_prepared", Callable(self, "on_chicken_is_prepared"))
		chicken.connect("eggs_spawned", Callable(self, "on_eggs_spawned"))
		chicken.connect("chicken_was_clicked", Callable(self, "on_chicken_was_clicked"))

func on_chicken_is_prepared():
	print("Game: получен сигнал chicken_is_prepared")

func on_eggs_spawned(count):
	print("Game: получен сигнал eggs_spawned =", count)

func on_chicken_was_clicked(chicken):
	print("Game: получен сигнал chicken_was_clicked")
	
	var egg = egg_scene.instantiate()
	eggs_container.add_child(egg)
	egg.global_position = chicken.global_position
	
	var tween = get_tree().create_tween()
	tween.tween_property(egg, "position:y", egg.position.y - 100, 0.8).as_relative()
	tween.tween_callback(Callable(egg, "queue_free"))
	tween.play()

func set_cursor(scale = Vector2(7, 7)) -> void:
	custom_cursor.scale = 7
