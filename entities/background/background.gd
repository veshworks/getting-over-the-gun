@tool
extends CanvasLayer
class_name Background

@onready var parallax_background: ParallaxBackground = %ParallaxBackground
@onready var texture_rect: TextureRect = %TextureRect
signal update_height(height: float)

@export var do_auto_scroll: bool = false

@export var height_max: float = 2000
@export var height_min: float = 0

@export var debug_height: float = 0:
	set(value):
		debug_height = value
		update_height.emit(value)

func _ready() -> void:
	update_height.connect(pass_height_to_shader)
	SceneManager.singleton.stage_changed.connect(func():
		parallax_background.scroll_offset.y = 0
		)

func _process(delta: float) -> void:
	if Engine.is_editor_hint(): return
	if do_auto_scroll:
		parallax_background.scroll_offset.x -= 100 * delta

func pass_height_to_shader(height: float) -> void:
	var normal_height = (height_min - height)/(height_max - height_min);
	texture_rect.material.set_shader_parameter("height", normal_height)
