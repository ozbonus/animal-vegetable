extends Node


@export_category("Debug")
@export var debug: bool = false
@export var p1_debug_score: int = 1000
@export var p2_debug_score: int = 15000
@export var p3_debug_score: int = 800
@export var p4_debug_score: int = 12345
@export_category("Settings")
@export var count_time: float = 3.0


var p1_score: int = PlayerRepository.p1_score
var p2_score: int = PlayerRepository.p2_score
var p3_score: int = PlayerRepository.p3_score
var p4_score: int = PlayerRepository.p4_score


func _ready():
	MusicService.play_title_music(1.0)
	if debug:
		p1_score = p1_debug_score
		p2_score = p1_debug_score
		p3_score = p3_debug_score
		p4_score = p4_debug_score
	
	$P1Points.text = str(p1_score)
	$P2Points.text = str(p2_score)
	$P3Points.text = str(p3_score)
	$P4Points.text = str(p4_score)


func _process(delta):
	if Input.is_action_just_pressed("next_screen"):
		ScreenTransition.change_screen("res://title_screen.tscn")
	if Input.is_action_just_pressed("previous_screen"):
		ScreenTransition.change_screen("res://play_screen.tscn")
