extends Node2D


onready var _player = $Player

var time_elapsed = 0


func _ready():
	Events.connect("entity_spawned", self, "_on_entity_spawned")
	_player.connect("destroyed", self, "_game_over")
	_setup()


func _setup():
	randomize()
	
	$Spawner.spawn()


func _on_entity_spawned(entity):
	add_child(entity)
	
	if entity.is_in_group("enemies"):
		entity.connect("destroyed", _player, "refuel")


func _game_over():
	var game_over = load("res://ui/game_over/game_over.tscn").instance()
	$UI.add_child(game_over)
	game_over.set_time(time_elapsed)


func _process(delta):
	time_elapsed += delta
	
	if is_instance_valid($Player):
		$CanvasLayer/Overlay.set_radius($Player._health.get_health_percentage())
	else:
		$CanvasLayer/Overlay.set_radius(1.0)
