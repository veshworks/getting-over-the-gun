extends VBoxContainer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		self.visible = !self.visible

func _ready() -> void:
	self.visible = false
