extends Control


export(NodePath) var ship

onready var _ship = get_node(ship)
onready var _fuel_gauge = $FuelGauge


func _process(delta):
	if not _ship or not is_instance_valid(_ship):
		return
	
	_fuel_gauge.value = _ship.fuel
