extends Control


export(float) var lifetime_duration = 10.0


func _ready():
	get_tree().create_timer(lifetime_duration).connect("timeout", self, "_on_timeout")


func _on_timeout():
	$AnimationPlayer.play("fade")


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
