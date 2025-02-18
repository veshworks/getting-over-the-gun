extends Node2D
class_name FinishPole

@export var win_layer: MenuWin

var has_triggered = false


func _ready() -> void:
	win_layer.visible = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if has_triggered: return
	if not body is Player: return
	has_triggered = true
	win_layer.display(GameState.singleton.stopwatch_end())
