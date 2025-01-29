extends CanvasLayer
class_name HUD

@export var game_state: GameState
@export var target: Node2D

@onready var time_display: Label = %TimeDisplay
@onready var sub_viewport: SubViewport = %SubViewport
@onready var camera_minimap: Camera2D = %CameraMinimap

static var singleton: HUD

static var camera: Camera2D:
	get():
		return singleton.camera_minimap

var target_position_old: Array[Vector2] = []

func _ready() -> void:
	if singleton:
		assert(false, "HUD Singleton Already Exists")
	singleton = self
	sub_viewport.world_2d = get_viewport().world_2d
	target_position_old.push_back(target.position)


func _physics_process(delta: float) -> void:
	camera_minimap.offset = target.position - target_position_old.back() 
	camera_minimap.position = target.position
	target_position_old.push_front(target.position)
	target_position_old.resize(min(target_position_old.size(), 20))


func _process(delta: float) -> void:
	time_display.text = game_state.stopwatch_diplay

func _exit_tree() -> void:
	singleton = null
