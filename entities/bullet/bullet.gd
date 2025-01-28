extends Sprite2D
class_name Bullet

var direction: Vector2 = Vector2.RIGHT

@export var speed: int = 800

func _ready() -> void:
	self.visible = false

func _physics_process(delta: float) -> void:
	position += direction * delta * speed


func shoot(position: Vector2, rotation: float) -> void:
	self.process_mode = Node.PROCESS_MODE_INHERIT
	self.visible = true
	self.position = position
	self.rotation = rotation
	self.direction = Vector2(cos(rotation), sin(rotation))



func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	self.visible = false
	self.process_mode = Node.PROCESS_MODE_DISABLED
