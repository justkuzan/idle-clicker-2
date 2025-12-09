extends TextureRect

var cursor_default = preload("res://assets/hud/cursor/cursor_idle.png")
var cursor_hovered = preload("res://assets/hud/cursor/cursor_open.png")
var cursor_clicked = preload("res://assets/hud/cursor/cursor_grub.png")

var is_hovered = false

@onready var chicken = preload("res://elements/characters/chicken.tscn")

func _ready() -> void:
	Input.set_custom_mouse_cursor(cursor_default,Input.CURSOR_ARROW, Vector2(0, 0))
	Input.set_custom_mouse_cursor(cursor_hovered,Input.CURSOR_POINTING_HAND, Vector2(0, 0))
	Input.set_custom_mouse_cursor(cursor_clicked,Input.CURSOR_CAN_DROP, Vector2(0, 0))

func set_default_cursor():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	is_hovered = false

func set_hover_cursor():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	is_hovered = true

func set_click_cursor():
	Input.set_default_cursor_shape(Input.CURSOR_CAN_DROP)
	await get_tree().create_timer(0.1).timeout
	if is_hovered:
		set_hover_cursor()
	else:
		set_default_cursor()
