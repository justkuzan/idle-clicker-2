extends Node2D

var rnd := RandomNumberGenerator.new()
var eggs_generated := 0
enum ChickenState { IDLE, READY }
var state: ChickenState = ChickenState.IDLE

@onready var animation = $AnimatedSprite2D
@onready var timer = $Timer

func _ready() -> void:
	rnd.randomize()
	chicken_is_idle()
	start_random_timer()

func start_random_timer() -> void:
	timer.wait_time = rnd.randf_range(3.0, 7.0)
	print("Таймер установлен на %s секунд" % $Timer.wait_time)
	timer.start()

func chicken_is_idle():
	state = ChickenState.IDLE
	animation.play("idle")

func chicken_is_ready():
	state = ChickenState.READY
	animation.play("ready")

func eggs_generation():
	eggs_generated = rnd.randi_range(1, 5)
	print("Курочка сгенерировала %s яйца" % eggs_generated)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void: #subscribed to signal
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Персонажа нажали!")

func _on_timer_timeout() -> void:
	chicken_is_ready()
	print("Таймер закончился")
	eggs_generation()
