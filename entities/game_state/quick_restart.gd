extends Node

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var panel: Panel = $CanvasLayer/Panel

@onready var timer: Timer = $Timer
var tween: Tween

func _physics_process(_delta: float) -> void:
	if (Input.is_action_just_pressed("quick_restart")):
		panel.modulate.a = 0
		canvas_layer.visible = true
		timer.start()
		tween = get_tree().create_tween()
		tween.tween_method(modulate_alpha, panel.modulate.a, 1, timer.wait_time)
	if (Input.is_action_just_released("quick_restart")):
		canvas_layer.visible = false
		timer.stop()


func _on_timer_timeout() -> void:
	SceneManager.reload_current_stage()

func modulate_alpha(v: float):
	panel.modulate.a = v
