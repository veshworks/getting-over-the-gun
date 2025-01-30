extends Label

func _physics_process(_delta: float) -> void:
	self.text = GameState.singleton.player.is_idle(true)
