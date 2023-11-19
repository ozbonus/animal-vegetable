extends Node2D


signal game_over
@export_range(20.0, 60.0, 1.0) var game_length: float = 30
var has_started: bool = false
var label: int
var _label_int: int


func _ready():
	$Timer.wait_time = game_length
	label = int(game_length)
	$CenterContainer/Label.text = str(label)


func _process(delta):
	var new_label: int = int($Timer.time_left)
	if has_started and label != new_label:
		label = new_label
		$CenterContainer/Label.text = str(label)
		$AnimationPlayer.play("jiggle")


func start() -> void:
	has_started = true
	$Timer.start()


func _on_timer_timeout() -> void:
	$Timer.stop()
	game_over.emit()
