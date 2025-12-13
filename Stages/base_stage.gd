extends Node2D

enum State { IDLE, READY }
var chicken_is_ready := false
var eggs_count := 0

@onready var egg_scene = preload("res://Entities/Organisms/Chicken/Egg/egg.tscn")
@onready var eggs_container = $eggs
@onready var score_label = $score_label

func _ready() -> void:
	for chicken in get_tree().get_nodes_in_group("chickens"):
		chicken.connect("chicken_is_prepared", Callable(self, "on_chicken_is_prepared"))
		chicken.connect("eggs_spawned", Callable(self, "on_eggs_spawned"))
		chicken.connect("chicken_was_clicked", Callable(self, "on_chicken_was_clicked"))

func on_chicken_is_prepared():
	chicken_is_ready = true

func on_eggs_spawned(count):
	eggs_count = count

func on_chicken_was_clicked(chicken):
	egg_fly_animation(chicken)

func egg_fly_animation(chicken):
	var egg = egg_scene.instantiate() # create an egg
	eggs_container.add_child(egg) # throw it into the branch
	egg.global_position = chicken.global_position # put the egg in the chicken's position
	
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	
	var area2d = score_label.get_node("Area2D")
	var target_position = area2d.get_global_transform_with_canvas().origin
	
	tween.tween_property(egg, "global_position", target_position, 0.5)
	tween.finished.connect(egg.queue_free)
