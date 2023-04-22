extends Node
class_name Spawner


const EnemyScene = preload("res://entities/ship/enemy.tscn")

export(float) var spawn_cooldown_duration = 10.0
export(float) var spawn_range = 1000.0
export(float) var despawn_range = 2000.0
export(int) var spawn_count = 3

var _timer
var _player


func _ready():
	_timer = Timer.new()
	_timer.wait_time = spawn_cooldown_duration
	_timer.one_shot = false
	_timer.autostart = false
	add_child(_timer)
	_timer.connect("timeout", self, "_on_SpawnTimer_timeout")
	_timer.start()
	
	var players = get_tree().get_nodes_in_group("players")
	
	if not players.empty():
		_player = players[0]


func spawn():
	var enemies = get_tree().get_nodes_in_group("enemies")
	var count = spawn_count - enemies.size()
	
	for i in range(count):
		var enemy = EnemyScene.instance()
		var range_ = rand_range(spawn_range, despawn_range)
		var offset = Vector2.RIGHT.rotated(rand_range(0, TAU)) * range_
		enemy.global_position = _player.global_position + offset
		enemy.global_rotation = rand_range(0, TAU)
		
		Events.emit_signal("entity_spawned", enemy)


func _despawn_far_entities():
	var enemies = get_tree().get_nodes_in_group("enemies")
	
	for enemy in enemies:
		var out_of_range = enemy.global_position.distance_to(_player.global_position) > despawn_range
		if out_of_range:
			enemy.queue_free()


func _scale_up():
	spawn_count += 1


func _on_SpawnTimer_timeout():
	if not _player or not is_instance_valid(_player):
		return
	
	_despawn_far_entities()
	spawn()
	_scale_up()
