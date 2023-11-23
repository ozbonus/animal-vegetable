extends Node


@export_category("Debug")
@export var debug: bool = false
@export var p1_debug_score: int = 1000
@export var p2_debug_score: int = 15000
@export var p3_debug_score: int = 800
@export var p4_debug_score: int = 12345
@export_category("Settings")
@export var wait_time: float = 3.0


var p1_score: int = PlayerRepository.p1_score
var p2_score: int = PlayerRepository.p2_score
var p3_score: int = PlayerRepository.p3_score
var p4_score: int = PlayerRepository.p4_score
var wait_time_adjust: Array[float] = [1.0, 0.8, 0.6, 0.4]
var wait_time_index: int = 0
var player_scores: Dictionary


func _ready():
	MusicService.play_title_music(1.0)
	$ApplauseSound.play()
	
	if debug:
		player_scores["P1"] = p1_debug_score
		player_scores["P2"] = p2_debug_score
		player_scores["P3"] = p3_debug_score
		player_scores["P4"] = p4_debug_score
	else:
		if ActivePlayersRepository.p1_active:
			player_scores["P1"] = PlayerRepository.p1_score
		else:
			$P1Area.hide()
		if ActivePlayersRepository.p2_active:
			player_scores["P2"] = PlayerRepository.p2_score
		else:
			$P2Area.hide()
		if ActivePlayersRepository.p3_active:
			player_scores["P3"] = PlayerRepository.p3_score
		else:
			$P3Area.hide()
		if ActivePlayersRepository.p4_active:
			player_scores["P4"] = PlayerRepository.p4_score
		else:
			$P4Area.hide()
		
	manipulate_points()
	
	var sorted_scores: Array = player_scores.values()
	sorted_scores.sort_custom(func(a, b): return a > b)
	
	
	for score in sorted_scores:
		var player: String = player_scores.find_key(score)
		var time = wait_time * wait_time_adjust[wait_time_index]
		get_node("%sArea/%sPlayerScore" % [player, player]).start(time , player_scores[player])
		get_node("%sArea/AnimationPlayer" % player).play("rise")
		wait_time_index += 1


func _process(delta):
	if Input.is_action_just_pressed("next_screen"):
		ScreenTransition.change_screen("res://title_screen.tscn")
	if Input.is_action_just_pressed("previous_screen"):
		ScreenTransition.change_screen("res://play_screen.tscn")


func manipulate_points() -> void:
	for key in player_scores.keys():
		if player_scores[key] == 0:
			player_scores[key] = randi_range(1, 10) * 15
	
	for value in player_scores.values():
		while player_scores.values().count(value) > 1:
			var lucky: String = player_scores.find_key(value)
			player_scores[lucky] = value + randi_range(1, 10) * 15
	
	
			
	



func _on_p_1_player_score_finished(): $P1Area/AnimationPlayer.pause()


func _on_p_2_player_score_finished(): $P2Area/AnimationPlayer.pause()


func _on_p_3_player_score_finished(): $P3Area/AnimationPlayer.pause()


func _on_p_4_player_score_finished(): $P4Area/AnimationPlayer.pause()
