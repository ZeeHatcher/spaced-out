extends Node
class_name FlatHealth


signal depleted

export(int) var health = 3


func hurt():
	health = max(0, health - 1)
	
	if health <= 0:
		emit_signal("depleted")
