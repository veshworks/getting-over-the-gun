extends Node

@export var idle_input_threshold:= 50

var state: GameState:
	get():
		return self.get_parent()

var inputs_since_last_movement: int = 0
var list_of_actions:= Set.new()

func _ready() -> void:
	$CanvasLayer.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_type():
		inputs_since_last_movement += 1
		for action in InputMap.get_actions():
			if !event.is_action(action): continue
			list_of_actions.add(action)

	var has_exceeded_limit = inputs_since_last_movement > idle_input_threshold
	var has_tried_it_all = list_of_actions.has_all([
		'shoot',
		'left',
		'right',
		'nudge',
	])

	if has_exceeded_limit and has_tried_it_all:
		get_tree().paused = true
		$CanvasLayer.visible = true

func _physics_process(_delta: float) -> void:
	if !state.player.is_idle():
		inputs_since_last_movement = 0
		list_of_actions.erase_all()
