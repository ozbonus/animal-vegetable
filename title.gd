extends CanvasLayer

@export_range(1, 100) var frequency: float = 5
@export_range(1, 200) var amplitude: float = 150
@export_range(1, 100) var time_shift: float = 2
var time = 0

func _physics_process(delta):
	time += delta
	for child in get_children():
		var shift: float = (child.get_index() + 1) * time_shift
		var movement = cos((time - shift) * frequency) * amplitude
		child.get_index()
		child.position.y += movement * delta
