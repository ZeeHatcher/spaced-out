extends Node
class_name AIController


export(float) var view_range = 500.0
export(float) var field_of_view = 0.9

var _target


func _ready():
	var players = get_tree().get_nodes_in_group("players")
	
	if not players.empty():
		_target = players[0]


func handle(ship: Ship) -> void:
	if not _target or not is_instance_valid(_target):
		return
	
	ship.rotation_dir = sign(ship.get_angle_to(_target.global_position))
	ship.is_thrusting = true
	
	if _target_within_range(ship) and _target_in_sight(ship):
		ship.shoot()


func _target_within_range(ship):
	return ship.global_position.distance_to(_target.global_position) < view_range


func _target_in_sight(ship):
	var facing = Vector2.RIGHT.rotated(ship.global_rotation)
	var target_direction = ship.global_position.direction_to(_target.global_position)
	
	return facing.dot(target_direction) > field_of_view
