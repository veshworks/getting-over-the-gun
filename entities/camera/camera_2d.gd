extends Camera2D

@export var player: Player
@export var finish_pole: FinishPole
@export var speed: float = 15
@export var start_offset: Vector2
@export var tween_duration: float = 2

var target: Node2D

func _ready() -> void:
	self.offset = start_offset
	self.position_smoothing_enabled = false
	self.position = finish_pole.position + offset
	target = finish_pole
	await get_tree().create_timer(1).timeout
	target = player
	
	var tween = create_tween() \
		.set_trans(Tween.TRANS_EXPO) \
		.set_ease(Tween.EASE_IN_OUT) \
		.set_parallel(true)
		
	tween.tween_property(self, "position", target.position, tween_duration)
	tween.tween_property(self, "offset", Vector2.ZERO, tween_duration)
	await tween.finished
	self.position_smoothing_enabled = true

func _process(delta: float) -> void:
	self.position = target.position
	pass
