extends CanvasLayer
class_name HUD

@onready var time_display: Label = %TimeDisplay

var time: float = 0.0


func _physics_process(delta: float) -> void:
	time += delta
	var h = floor(time / 3600)
	var min = fmod(time, 3600) / 60
	var s = fmod(time, 60)
	var ms = fmod(time, 1) * 100
	time_display.text = "%02d:%02d:%02d.%02d" % [h, min, s, ms]
