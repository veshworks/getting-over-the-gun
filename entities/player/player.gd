extends RigidBody2D
class_name Player

@onready var bullet_origin: Marker2D = $BulletOrigin
@onready var force_origin: Marker2D = $ForceOrigin
@onready var nudge_origin: Marker2D = $NudgeOrigin
@onready var gun_shot_sound_player: AudioStreamPlayerPool = $GunShotSoundPlayer
@onready var gun_hammer_sound_player: AudioStreamPlayerPool = $GunHammerSoundPlayer
@onready var ground_hit_audio_stream_player_pool: AudioStreamPlayerPool = $GroundHitAudioStreamPlayerPool

@export var background: Background

@export var bullet_scene: PackedScene
@export var bullet_force = 300

@export var max_angular_velocity: float = 10

const AIR_DRAG = 10

var bullet_momentum = Vector2.ZERO
var bullet_pool: Array[Bullet]

func _ready() -> void:
	while bullet_pool.size() < 20:
		var inst = bullet_scene.instantiate() as Bullet
		get_tree().root.add_child(inst)
		bullet_pool.append(inst)
	GameState.singleton.update_angular_damp.connect(func(value):
		self.angular_damp = value
		)

func _physics_process(delta: float) -> void:
	var rotation = Input.get_axis("left", "right")
	self.apply_torque_impulse(rotation * 1000)
	
	if (Input.is_action_just_pressed("shoot")):
		var bullet = bullet_pool.pop_back() as Bullet
		bullet.shoot(bullet_origin.global_position, self.rotation)
		bullet_pool.push_front(bullet)
		gun_shot_sound_player.play_immediately()
		self.apply_impulse((bullet.direction * -1) * bullet_force, force_origin.position)
	
	if Input.is_action_just_pressed("reload"):
		var up = get_gravity().normalized() * -1
		self.apply_impulse(up * 100, nudge_origin.position)
		self.apply_torque_impulse(-10000)
		gun_hammer_sound_player.play_immediately()

func _process(_delta: float) -> void:
	background.update_height.emit(position.y)


func _on_body_entered(body: Node) -> void:
	ground_hit_audio_stream_player_pool.play_immediately()
