extends Node2D

@onready var egg_scene = preload("res://elements/characters/egg.tscn")
@onready var eggs_container = $eggs
@onready var custom_cursor = $custom_cursor
@onready var score_label = $score_label

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
	
	var egg = egg_scene.instantiate() # create an egg
	eggs_container.add_child(egg) # throw it into the branch
	egg.global_position = chicken.global_position # put the egg in the chicken's position
	
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	
	var target_pos = score_label.area2d.get_global_transform_with_canvas().origin
	tween.tween_property(egg, "global_position", target_pos, 0.5)
	tween.finished.connect(egg.queue_free)
