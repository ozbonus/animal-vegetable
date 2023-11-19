extends Node


enum State {COUNTDOWN, PLAY, FINISHED}


@export var debug: bool = false
@export var debug_state: State
var p1_active: bool = ActivePlayersRepository.p1_active
var p2_active: bool = ActivePlayersRepository.p2_active
var p3_active: bool = ActivePlayersRepository.p3_active
var p4_active: bool = ActivePlayersRepository.p4_active
var state: State


func _ready():
	MusicService.play_gameplay_music(1.0)
	PlayerRepository.reset_scores()
	if !p1_active and !debug:
		$P1PlayArea.queue_free()
	if !p2_active and !debug:
		$P2PlayArea.queue_free()
	if !p3_active and !debug:
		$P3PlayArea.queue_free()
	if !p4_active and !debug:
		$P4PlayArea.queue_free()
	
	if debug:
		state = debug_state
	else:
		state = State.COUNTDOWN



func _process(delta):
	if Input.is_action_just_pressed("previous_screen"):
		ScreenTransition.change_screen("res://tutorial_screen.tscn")
	
	if Input.is_action_just_pressed("next_screen"):
		ScreenTransition.change_screen("res://score_screen.tscn")
	
	match state:
		State.COUNTDOWN:
			pass
		State.PLAY:
			
	
