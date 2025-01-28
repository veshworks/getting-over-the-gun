extends Node
class_name GameState

var stopwatch: float = 0.0

var stopwatch_enabled:= false
var stopwatch_diplay: String:
	get():
		var h = floor(stopwatch / 3600)
		var min = fmod(stopwatch, 3600) / 60
		var s = fmod(stopwatch, 60)
		var ms = fmod(stopwatch, 1) * 100
		return "%02d:%02d:%02d.%02d" % [h, min, s, ms]

func _ready() -> void:
	singleton = self
	stopwatch_begin()

func _process(delta: float) -> void:
	if stopwatch_enabled:
		stopwatch += delta

func stopwatch_begin() -> void:
	stopwatch = 0
	stopwatch_enabled = true

func stopwatch_end() -> String:
	stopwatch_enabled = false
	return stopwatch_diplay

static var process_input = true

static func stop() -> void:
	process_input = false
