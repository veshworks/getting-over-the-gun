@tool
extends CanvasLayer
class_name Background

@onready var texture_rect: TextureRect = $TextureRect
signal update_height(height: float)

@export var height_max: float = 2000
@export var height_min: float = 0

@export var debug_height: float = 0:
	set(value):
		debug_height = value
		update_height.emit(value)

func _ready() -> void:
	update_height.connect(pass_height_to_shader)

func pass_height_to_shader(height: float) -> void:
	var normal_height = (height_min - height)/(height_max - height_min);
	texture_rect.material.set_shader_parameter("height", normal_height)
