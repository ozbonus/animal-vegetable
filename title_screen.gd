extends Node


func _ready():
	ActivePlayersRepository.reset()
	PlayerRepository.reset()
	$BannerAnimation.play("RESET")
	

func _process(delta):
	if Input.is_action_pressed("next_screen"):
		ScreenTransition.change_screen("res://age_screen.tscn")
	if Input.is_action_just_pressed("command_1"):
		p1_toggle_active()
	if Input.is_action_just_pressed("command_2"):
		p2_toggle_active()
	if Input.is_action_just_pressed("command_3"):
		p3_toggle_active()
	if Input.is_action_just_pressed("command_4"):
		p4_toggle_active()
	


func p1_toggle_active():
	if !ActivePlayersRepository.p1_active:
		$PlayerReadyBanner1.activate()
	else:
		$PlayerReadyBanner1.deactivate()
	ActivePlayersRepository.p1_toggle_active()


func p2_toggle_active():
	if !ActivePlayersRepository.p2_active:
		$PlayerReadyBanner2.activate()
	else:
		$PlayerReadyBanner2.deactivate()
	ActivePlayersRepository.p2_toggle_active()


func p3_toggle_active():
	if !ActivePlayersRepository.p3_active:
		$PlayerReadyBanner3.activate()
	else:
		$PlayerReadyBanner3.deactivate()
	ActivePlayersRepository.p3_toggle_active()


func p4_toggle_active():
	if !ActivePlayersRepository.p4_active:
		$PlayerReadyBanner4.activate()
	else:
		$PlayerReadyBanner4.deactivate()
	ActivePlayersRepository.p4_toggle_active()
