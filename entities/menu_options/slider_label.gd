extends HSlider

@export var label: Label

func _ready() -> void:
	self.value_changed.connect(func(value: float):
		label.text = str(value)
		)
