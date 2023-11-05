extends ParallaxBackground

@export var x_speed: float = 1.0
@export var y_speed: float = 1.0

func _process(delta):
	$ParallaxLayer.motion_offset.x += x_speed
	$ParallaxLayer.motion_offset.y += y_speed
