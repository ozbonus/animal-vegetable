extends Node2D

@export_range(0, 1.5) var seek_delay: float = 0.0


func _ready():
	$AnimationPlayer.play("wave")
	$AnimationPlayer.seek(seek_delay)
