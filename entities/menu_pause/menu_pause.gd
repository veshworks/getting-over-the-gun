extends CanvasLayer

func _ready() -> void:
	self.visible = false


func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("pause"): return
	toggle_pause_state()

func toggle_pause_state() -> void:
	var tree = get_tree()
	self.visible = !tree.paused
	tree.paused = !tree.paused

func _exit_tree() -> void:
	get_tree().paused = false


func _on_button_button_down() -> void:
	toggle_pause_state()


func _on_restart_button_down() -> void:
	SceneManager.reload_current_stage()
