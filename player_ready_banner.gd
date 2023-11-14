extends Node2D


@export_enum("1", "2", "3", "4") var player_num: String = "1"


func _ready():
	$Sprite2D/Label2.text = player_num
	$AnimationPlayer.play("RESET")


func activate() -> void:
	$AnimationPlayer.play("up")
	$ActivateSound.play()

func deactivate() -> void:
	$AnimationPlayer.play("down")
	$DeactivateSound.play()
