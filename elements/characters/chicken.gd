extends Node2D

enum State { IDLE, READY }
var state = State.IDLE

var rnd := RandomNumberGenerator.new()
var eggs_generated := 0

signal chicken_is_prepared
signal eggs_spawned(count)
signal chicken_was_clicked(chicken)

@onready var animation = $AnimatedSprite2D
@onready var timer = $Timer

func _ready() -> void:
	add_to_group("chickens")
	rnd.randomize()
	chicken_is_idle()
	start_random_timer()

func change_state(new_state: State):
	state = new_state

func start_random_timer() -> void:
	timer.wait_time = rnd.randf_range(3.0, 7.0)
	print("Таймер установлен на %s секунд" % timer.wait_time)
	timer.start()

func chicken_is_idle():
	change_state(State.IDLE)
	animation.play("idle")

func chicken_is_ready():
	change_state(State.READY)
	animation.play("ready")
	print("Курочка готова!")
	emit_signal("chicken_is_prepared")

func eggs_generation():
	eggs_generated = rnd.randi_range(1, 5)
	print("Курочка сгенерировала %s яйца" % eggs_generated)
	emit_signal("eggs_spawned", eggs_generated)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void: #subscribed to signal
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Персонажа нажали!")
		emit_signal("chicken_was_clicked", self)

func _on_timer_timeout() -> void:
	chicken_is_ready()
	print("Таймер закончился")
	eggs_generation()
