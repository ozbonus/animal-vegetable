extends Node


@export var debug: bool = false
var p1_active: bool = ActivePlayersRepository.p1_active
var p2_active: bool = ActivePlayersRepository.p2_active
var p3_active: bool = ActivePlayersRepository.p3_active
var p4_active: bool = ActivePlayersRepository.p4_active


func _ready():
	PlayerRepository.reset_scores()
	if !p1_active and !debug:
		$P1PlayArea.queue_free()
	if !p2_active and !debug:
		$P2PlayArea.queue_free()
	if !p3_active and !debug:
		$P3PlayArea.queue_free()
	if !p4_active and !debug:
		$P4PlayArea.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("previous_screen"):
		ScreenTransition.change_screen("res://age_screen.tscn")
	
	if Input.is_action_just_pressed("next_screen"):
		ScreenTransition.change_screen("res://score_screen.tscn")
	
