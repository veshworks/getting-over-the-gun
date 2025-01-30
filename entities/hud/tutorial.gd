extends PanelContainer

@onready var timer: Timer = $Timer
@export var tutorial_duration = 10
@export var idle_duration = 2.5

var is_tutorial = true
var tween: Tween

func _ready() -> void:
	timer.wait_time = tutorial_duration
	timer.start()
	await timer.timeout
	tween = create_tween()
	tween.tween_method(modulate_alpha, self.modulate.a, 0, 0.3)
	tween.tween_callback(func():
		timer.timeout.connect(_on_timeout)
		timer.wait_time = idle_duration
		timer.start()
		tween.kill()
		is_tutorial = false
		)

func _physics_process(_delta: float) -> void:
	if is_tutorial: return
	if not GameState.singleton.stopwatch_enabled:
		timer.stop()
		return
	
	var is_idle = GameState.singleton.player.is_idle()
	if is_idle && timer.is_stopped():
		timer.start()
	if not is_idle and !timer.is_stopped():
		timer.stop()
		if tween && tween.is_valid():
			tween.kill()
		tween = create_tween()
		tween.tween_method(modulate_alpha, self.modulate.a, 0, 0.1)
		timer.start()

func _on_timeout() -> void:
	tween = create_tween()
	tween.tween_method(modulate_alpha, self.modulate.a, 1, 0.3)
	pass

func modulate_alpha(v: float) -> void:
	self.modulate.a = v
