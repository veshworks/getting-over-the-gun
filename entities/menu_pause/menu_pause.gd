extends CanvasLayer

func _ready() -> void:
	self.visible = false


func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("pause"): return
	var tree = get_tree()
	self.visible = !tree.paused
	tree.paused = !tree.paused

func _exit_tree() -> void:
	get_tree().paused = false
