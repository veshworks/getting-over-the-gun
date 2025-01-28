extends CanvasLayer
class_name MenuWin


func _ready() -> void:
	self.visible = false

func _exit_tree() -> void:
	get_tree().paused = false

func display(time: String) -> void:
	self.visible = true
	%Time.text = %Time.text % time
