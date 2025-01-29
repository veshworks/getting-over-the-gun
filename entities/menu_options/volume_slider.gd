extends HSlider

@export var bus: StringName
var bus_id

func _ready() -> void:
	bus_id = AudioServer.get_bus_index(bus)
	self.value = db_to_linear(AudioServer.get_bus_volume_db(bus_id))
	self.value_changed.connect(_on_h_slider_value_changed)

func _on_h_slider_value_changed(val: float) -> void:
	AudioServer.set_bus_volume_db(bus_id, linear_to_db(val))
