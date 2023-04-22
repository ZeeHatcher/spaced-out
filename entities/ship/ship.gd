extends KinematicBody2D
class_name Ship


signal destroyed

export(int) var max_speed := 300
export(int) var acceleration := 300
export(float) var friction := 0.01
export(float) var rotation_speed := 3.5
export(float) var fuel_consumption_rate := 2.0
export(NodePath) var controller
export(NodePath) var health

var velocity := Vector2()
var rotation_dir := 0
var is_thrusting := false
var fuel := 100.0

onready var _turret = $Turret
onready var _controller = get_node(controller)
onready var _health = get_node(health)
onready var _hit_audio_player = $HitAudio
onready var _engine_audio_player := $EngineAudio


func _ready():
	if _health:
		_health.connect("depleted", self, "_on_Health_depleted")


func _physics_process(delta: float) -> void:
	is_thrusting = false
	rotation_dir = 0
	
	if _controller:
		_controller.handle(self)
	
	rotation += rotation_dir * rotation_speed * delta
	_calculate_velocity(delta)
	
	velocity = move_and_slide(velocity)
	
	if is_thrusting:
		fuel = max(0.0, fuel - fuel_consumption_rate * delta)
		
	if is_thrusting and fuel > 0:
		if not _engine_audio_player.playing:
			_engine_audio_player.play(0.0)
	else:
		_engine_audio_player.stop()


func shoot():
	_turret.shoot()


func hurt():
	if _health:
		_health.hurt()
		_hit_audio_player.play()


func _calculate_velocity(delta: float) -> void: 
	if _has_fuel() and is_thrusting:
		velocity += Vector2(acceleration * delta, 0.0).rotated(rotation)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
	
	velocity = velocity.limit_length(max_speed)


func refuel():
	fuel = min(fuel + 25.0, 100.0)


func _has_fuel() -> bool:
	return fuel > 0.0


func _on_Health_depleted():
	emit_signal("destroyed")
	var death_audio = load("res://audio/death_audio.tscn").instance()
	get_tree().root.get_node("Main").add_child(death_audio)
	queue_free()
