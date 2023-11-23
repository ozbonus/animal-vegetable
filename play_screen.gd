extends Node


@export var debug: bool = false
var p1_active: bool = ActivePlayersRepository.p1_active
var p2_active: bool = ActivePlayersRepository.p2_active
var p3_active: bool = ActivePlayersRepository.p3_active
var p4_active: bool = ActivePlayersRepository.p4_active
var active_players: Array[Node]


func _ready():
	MusicService.play_gameplay_music(5.0)
	$FinishedLabel.hide()
	PlayerRepository.reset_scores()
	if !p1_active and !debug:
		$P1PlayArea.queue_free()
	else:
		active_players.append($P1PlayArea)
	if !p2_active and !debug:
		$P2PlayArea.queue_free()
	else:
		active_players.append($P2PlayArea)
	if !p3_active and !debug:
		$P3PlayArea.queue_free()
	else:
		active_players.append($P3PlayArea)
	if !p4_active and !debug:
		$P4PlayArea.queue_free()
	else:
		active_players.append($P4PlayArea)


func _process(delta):
	if Input.is_action_just_pressed("previous_screen"):
		ScreenTransition.change_screen("res://tutorial_screen.tscn")
	
	if Input.is_action_just_pressed("next_screen"):
		ScreenTransition.change_screen("res://score_screen.tscn")
	

func _on_countdown_animation_animation_finished(anim_name):
	$CountdownLabel.hide()
	active_players.map(func(x): x.start_game())
	$GameTimer.start()


func _on_game_timer_game_over():
	active_players.map(func(x): x.finish_game())
	$FinishedLabel.show()
	$FinishedLabelAnimation.play("appear")
	$Whistle.play()
	MusicService._stop_gameplay_music()
