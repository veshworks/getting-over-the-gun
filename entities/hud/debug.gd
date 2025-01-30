extends MarginContainer

func _ready() -> void:
	self.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		self.visible = !self.visible
		
		if self.visible:
			$VBoxContainer.process_mode = Node.PROCESS_MODE_INHERIT
		else:
			$VBoxContainer.process_mode = Node.PROCESS_MODE_DISABLED
