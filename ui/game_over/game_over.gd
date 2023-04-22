extends Control


var _can_continue = false


func _ready():
	$AnimationPlayer.play("show")


func _input(event):
	if _can_continue and event.is_action_pressed("action"):
		get_tree().change_scene("res://scenes/main/main.tscn")


func _on_AnimationPlayer_animation_finished(anim_name):
	_can_continue = true
