extends Node2D
class_name FinishPole

@export var win_layer: MenuWin
@export var game_state: GameState


func _ready() -> void:
	win_layer.visible = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body is Player: return
	win_layer.display(game_state.stopwatch_end())
	game_state.stop()
