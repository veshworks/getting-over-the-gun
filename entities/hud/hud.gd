extends CanvasLayer
class_name HUD

@export var game_state: GameState
@onready var time_display: Label = %TimeDisplay

func _process(delta: float) -> void:
	time_display.text = game_state.stopwatch_diplay
