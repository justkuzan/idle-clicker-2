extends CanvasLayer

signal label_area_was_entered()

@onready var area2d = $Area2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	emit_signal("label_area_was_entered")
	print("Получили яйцо")
