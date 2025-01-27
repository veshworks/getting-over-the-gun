extends Camera2D

@export var player: Player
@export var finish_pole: FinishPole
@export var speed: float = 15

var target: Node2D

func _ready() -> void:
	self.position_smoothing_enabled = false
	self.position = finish_pole.position
	target = finish_pole
	await get_tree().create_timer(1).timeout
	target = player
	var tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position", target.position, 2)
	tween.tween_callback(func(): self.position_smoothing_enabled = true)

func _process(delta: float) -> void:
	self.position = target.position
	pass
