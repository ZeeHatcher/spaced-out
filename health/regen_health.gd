extends Node
class_name RegenHealth


signal depleted

export(float) var health_regen_rate = 20.0

var _health = 100.0


func _physics_process(delta):
	_health = min(_health + health_regen_rate * delta, 100.0)


func hurt():
	_health = max(0.0, _health - 20.0)
	
	if _health <= 0.0:
		emit_signal("depleted")


func get_health_percentage():
	return _health / 100
