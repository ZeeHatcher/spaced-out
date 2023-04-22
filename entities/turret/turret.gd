extends Node2D
class_name Turret


signal shot()

const MAX_HEAT = 100.0

export(PackedScene) var ProjectileScene
export(float) var heat_cooldown_rate = 20.0
export(float) var heat_gain_rate = 10.0
export(float) var shoot_cooldown_duration = 0.1

var heat = 0.0

var _can_shoot = true
var _timer


func _ready():
	_timer = Timer.new()
	_timer.wait_time = shoot_cooldown_duration
	_timer.one_shot = true
	_timer.autostart = false
	add_child(_timer)
	_timer.connect("timeout", self, "_on_ShootTimer_timeout")


func _physics_process(delta):
	heat = max(0.0, heat - heat_cooldown_rate * delta)


func shoot():
	if not _can_shoot or heat > MAX_HEAT - heat_gain_rate:
		return
	
	if ProjectileScene:
		var projectile = ProjectileScene.instance()
		projectile.global_rotation = global_rotation
		projectile.global_position = global_position
		Events.emit_signal("entity_spawned", projectile)
		emit_signal("shot")
	
	heat += heat_gain_rate
	_can_shoot = false
	
	_timer.start()


func _on_ShootTimer_timeout():
	_can_shoot = true
