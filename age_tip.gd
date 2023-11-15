extends Node2D

@export_range(0.0, 2.0, 0.1) var seek_delay: float = 0.0


func _ready():
	$AnimationPlayer.play("wave")
	$AnimationPlayer.seek(seek_delay)
