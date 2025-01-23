extends Sprite2D
class_name Bullet

var SCREEN_SIZE = DisplayServer.screen_get_size()
var BULLET_MAX_DIST = max(SCREEN_SIZE.x, SCREEN_SIZE.y)

var direction: Vector2 = Vector2.RIGHT:
	set(value):
		direction = value.normalized()

@export var speed: int = 800

func _physics_process(delta: float) -> void:
	position += direction * delta * speed
	
	if min(abs(position.x), abs(position.y)) > BULLET_MAX_DIST:
		self.queue_free()
