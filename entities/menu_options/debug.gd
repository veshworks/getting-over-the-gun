extends VBoxContainer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		self.visible = !self.visible

func _ready() -> void:
	self.visible = false
	
	if !GameState.singleton:
		%AngularDamp.editable = false
		%BulletForce.editable = false
		return
	%AngularDamp.value = GameState.singleton.player.angular_damp
	%BulletForce.value = GameState.singleton.player.bullet_force


func _on_bullet_force_value_changed(value: float) -> void:
	SceneManager.set_payload('bullet_force', value)


func _on_angular_damp_value_changed(value: float) -> void:
	SceneManager.set_payload('angular_damp', value)
