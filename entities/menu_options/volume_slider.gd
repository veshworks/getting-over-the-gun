extends HSlider

func _ready() -> void:
	self.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	self.value_changed.connect(_on_h_slider_value_changed)

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
