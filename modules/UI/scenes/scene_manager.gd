extends Node
class_name SceneManager
## This Node should be the root node of the main scene project

const CHILD_SCHENE_NAME = "scene"

@export var main_scene: PackedScene

static var singleton: SceneManager:
	get():
		if !singleton:
			assert(false, "Error: singleton not loaded")
			return
		return singleton

static func get_payload(key):
	var pay = SceneManager.singleton.payloads
	var value = pay[key]
	pay.erase(key)
	return value
static func set_payload(key, value):
	SceneManager.singleton.payloads[key] = value
	SceneManager.singleton.payload_updated.emit(key)

static func go_back(index: int = -1):
	SceneManager.singleton.current_cursor += index
	SceneManager.singleton.update_current_view()

static func get_current_stage() -> Node:
	return SceneManager.singleton.current_instance

signal payload_updated(key: Variant)

var payloads: Dictionary = {}

var current_cursor: int = 0
var history: Array[PackedScene] = []
var last_scene: PackedScene:
	get():
		return history.back()

var current_instance: Node

func _ready() -> void:
	singleton = self
	
	current_instance = main_scene.instantiate()
	history.append(main_scene)
	current_instance.name = CHILD_SCHENE_NAME
	self.add_child(current_instance)


func change_scene_to_packed(scene: PackedScene) -> void:
	if current_cursor != history.size() - 1:
		history.resize(current_cursor + 1)
	
	history.append(scene)
	current_cursor += 1
	update_current_view()

func update_current_view() -> void:
	var scene = history[current_cursor]
	self.remove_child(self.find_child(CHILD_SCHENE_NAME+"*", false, false))
	current_instance = scene.instantiate()
	current_instance.name = CHILD_SCHENE_NAME
	self.add_child(current_instance)
