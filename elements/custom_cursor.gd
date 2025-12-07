extends TextureRect

var cursor_default = preload("res://assets/hud/cursor/cursor_idle.png")
var cursor_hovered = preload("res://assets/hud/cursor/cursor_open.png")
var cursor_clicked = preload("res://assets/hud/cursor/cursor_grub.png")
@onready var chicken = preload("res://elements/characters/chicken.tscn")

func _ready() -> void:
	Input.set_custom_mouse_cursor(cursor_default,Input.CURSOR_ARROW, Vector2(14, 14))

func _process(delta: float) -> void:
	position = get_global_mouse_position()

func on_chicken_is_prepared():
	Input.set_custom_mouse_cursor(cursor_hovered, Input.CURSOR_ARROW, Vector2(14, 14))
