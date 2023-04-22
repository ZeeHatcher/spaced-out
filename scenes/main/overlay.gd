extends TextureRect


func set_radius(radius):
	material.set_shader_param("circle_radius", radius)
