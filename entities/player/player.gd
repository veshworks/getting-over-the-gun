extends RigidBody2D

@onready var bullet_origin: Marker2D = $BulletOrigin
@onready var force_origin: Marker2D = $ForceOrigin
@onready var nudge_origin: Marker2D = $NudgeOrigin
@onready var gun_shot_sound_player: AudioStreamPlayerPool = $GunShotSoundPlayer
@onready var gun_hammer_sound_player: AudioStreamPlayerPool = $GunHammerSoundPlayer
@onready var ground_hit_audio_stream_player_pool: AudioStreamPlayerPool = $GroundHitAudioStreamPlayerPool

@export var background: Background

@export var bullet_scene: PackedScene
const BULLET_FORCE = 300

const AIR_DRAG = 10

var bullet_momentum = Vector2.ZERO
var is_on_floor = false

func _physics_process(delta: float) -> void:
	var rotation = Input.get_axis("left", "right")
	self.apply_torque_impulse(rotation * 1000)
	
	if (Input.is_action_just_pressed("shoot")):
		var inst = bullet_scene.instantiate() as Bullet
		var dir = Vector2(cos(self.rotation), sin(self.rotation))
		inst.direction = dir
		inst.position = bullet_origin.global_position
		inst.rotation = self.rotation
		get_tree().root.add_child(inst)
		gun_shot_sound_player.play_immediately()
		
		self.apply_impulse((dir * -1) * BULLET_FORCE, force_origin.position)
	
	if Input.is_action_just_pressed("reload") and is_on_floor:
		var up = Vector2(-sin(self.rotation), cos(self.rotation))
		self.apply_impulse(up * 100, nudge_origin.position)
		self.apply_torque_impulse(-10000)
		gun_hammer_sound_player.play_immediately()

func _process(_delta: float) -> void:
	background.update_height.emit(position.y)


func _on_body_entered(body: Node) -> void:
	#if not body.is_in_group("ground"): return
	is_on_floor = true
	ground_hit_audio_stream_player_pool.play_immediately()


func _on_body_exited(body: Node) -> void:
	#if not body.is_in_group("ground"): return
	is_on_floor = false
