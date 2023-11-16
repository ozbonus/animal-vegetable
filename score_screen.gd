extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicService.play_title_music(1.0)
	$P1Points.text = str(PlayerRepository.p1_score)
	$P2Points.text = str(PlayerRepository.p2_score)
	$P3Points.text = str(PlayerRepository.p3_score)
	$P4Points.text = str(PlayerRepository.p4_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("next_screen"):
		ScreenTransition.change_screen("res://title_screen.tscn")
	if Input.is_action_just_pressed("previous_screen"):
		ScreenTransition.change_screen("res://play_screen.tscn")
