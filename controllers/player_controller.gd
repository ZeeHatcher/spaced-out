extends Node
class_name PlayerController


func handle(ship: Ship) -> void:
	if Input.is_action_pressed("right"):
		ship.rotation_dir += 1
	if Input.is_action_pressed("left"):
		ship.rotation_dir -= 1
	
	ship.is_thrusting = Input.is_action_pressed("up")
	
	if Input.is_action_pressed("action"):
		ship.shoot()
