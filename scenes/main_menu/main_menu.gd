extends Control


func _input(event):
	if event.is_action_pressed("action"):
		get_tree().change_scene("res://scenes/main/main.tscn")
