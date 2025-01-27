extends Node2D
class_name FinishPole

@export var win_layer: CanvasLayer


func _ready() -> void:
	win_layer.visible = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body is Player: return
	win_layer.visible = true
	await get_tree().create_timer(1.5).timeout
	get_tree().paused = true
