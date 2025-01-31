extends Label

func _physics_process(_delta: float) -> void:
	var p = GameState.singleton.player
	self.text = str(p.angular_damp) + "/" + str(p.bullet_force)
