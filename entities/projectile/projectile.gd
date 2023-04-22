extends Area2D
class_name Projectile


export(int) var speed := 300
export(float) var lifetime := 2.0


func _ready():
	connect("body_entered", self, "_on_body_entered")
	get_tree().create_timer(lifetime).connect("timeout", self, "_on_DespawnTimer_timeout")


func _physics_process(delta: float) -> void:
	position += Vector2(speed * delta, 0.0).rotated(rotation)


func _hit(node: Node) -> void:
	if is_queued_for_deletion():
		return
	
	if node.has_method("hurt"):
		node.hurt()
	
	queue_free()


func _on_body_entered(body: KinematicBody2D):
	_hit(body)


func _on_DespawnTimer_timeout():
	queue_free()
