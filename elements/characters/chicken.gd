extends Node2D

@onready var idle_animation = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inner_physic_process("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func inner_physic_process(delta):
	idle_animation.play()
	
