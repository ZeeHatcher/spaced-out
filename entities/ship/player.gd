extends Ship


func _process(delta):
	$Polygon2D.modulate = Color.white.linear_interpolate(Color.orange, $Turret.heat/100)
