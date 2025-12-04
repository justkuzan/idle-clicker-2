extends Node2D

var rnd = RandomNumberGenerator.new()
var chicken_is_ready := false

@onready var animation = $AnimatedSprite2D
@onready var timer = $Timer

func _ready() -> void:
	rnd.randomize()
	timer.wait_time = rnd.randf_range(3.0, 7.0)
	print("Таймер установлен на %s секунд" % $Timer.wait_time)
	timer.start()
	
	_chicken_is_idle()

func _chicken_is_idle():
	animation.play("idle")
	
func _chicken_is_ready():
	animation.play("ready")
	chicken_is_ready = true

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void: #subscribed to signal
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Персонажа нажали!")

func _on_timer_timeout() -> void:
	_chicken_is_ready()
	print("Таймер закончился")
