extends Node


@export var debug: bool = true
var p1_active: bool = ActivePlayersRepository.p1_active
var p2_active: bool = ActivePlayersRepository.p2_active
var p3_active: bool = ActivePlayersRepository.p3_active
var p4_active: bool = ActivePlayersRepository.p4_active


func _ready():
	if !p1_active and !debug:
		$P1Content.queue_free()
	if !p2_active and !debug:
		$P2Content.queue_free()
	if !p3_active and !debug:
		$P3Content.queue_free()
	if !p4_active and !debug:
		$P4Content.queue_free()
	

func _process(delta):
	if Input.is_action_just_pressed("previous_screen"):
		ScreenTransition.change_screen("res://title_screen.tscn")
	
	if Input.is_action_just_pressed("next_screen"):
		ScreenTransition.change_screen("res://tutorial_screen.tscn")
	
	if p1_active or debug:
		if Input.is_action_just_pressed("p1_left"):
			$P1Content/AgeLabel.adjust_age(-1)
			PlayerRepository.p1_adjust_age(-1)
		if Input.is_action_just_pressed("p1_right"):
			$P1Content/AgeLabel.adjust_age(1)
			PlayerRepository.p1_adjust_age(1)

	if p2_active or debug:
		if Input.is_action_just_pressed("p2_left"):
			$P2Content/AgeLabel.adjust_age(-1)
			PlayerRepository.p2_adjust_age(-1)
		if Input.is_action_just_pressed("p2_right"):
			$P2Content/AgeLabel.adjust_age(1)
			PlayerRepository.p2_adjust_age(1)

	if p3_active or debug:
		if Input.is_action_just_pressed("p3_left"):
			$P3Content/AgeLabel.adjust_age(-1)
			PlayerRepository.p3_adjust_age(-1)
		if Input.is_action_just_pressed("p3_right"):
			$P3Content/AgeLabel.adjust_age(1)
			PlayerRepository.p3_adjust_age(1)

	if p4_active or debug:
		if Input.is_action_just_pressed("p4_left"):
			$P4Content/AgeLabel.adjust_age(-1)
			PlayerRepository.p4_adjust_age(-1)
		if Input.is_action_just_pressed("p4_right"):
			$P4Content/AgeLabel.adjust_age(1)
			PlayerRepository.p4_adjust_age(1)


