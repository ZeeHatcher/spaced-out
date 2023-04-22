extends Control


var _can_continue = false


func _ready():
	$AnimationPlayer.play("show")


func _input(event):
	if _can_continue and event.is_action_pressed("action"):
		get_tree().change_scene("res://scenes/main/main.tscn")


func _on_AnimationPlayer_animation_finished(anim_name):
	_can_continue = true


func set_time(time_elapsed):
	var minutes = time_elapsed / 60
	var seconds = int(time_elapsed) % 60
	$CenterContainer/VBoxContainer/Time.text = ("%d minutes %02d seconds" % [minutes, seconds])
