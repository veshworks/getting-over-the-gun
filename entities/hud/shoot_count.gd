extends Label

@onready var template = self.text
var count: int = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		count += 1
	self.text = template % count
