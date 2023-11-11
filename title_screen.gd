extends Node


func _ready():
	ActivePlayersRepository.reset()
	PlayerRepository.reset()
	$P1BannerAnimation.play("RESET")
	$P2BannerAnimation.play("RESET")
	$P3BannerAnimation.play("RESET")

func _process(delta):
	if Input.is_action_pressed("next_screen"):
		ScreenTransition.change_screen("res://age_screen.tscn")
	elif Input.is_action_just_pressed("p1_toggle_active"):
		p1_toggle_active()
	elif Input.is_action_just_pressed("p2_toggle_active"):
		p2_toggle_active()
	elif Input.is_action_just_pressed("p3_toggle_active"):
		p3_toggle_active()


func p1_toggle_active():
	if !ActivePlayersRepository.p1_active:
		$P1BannerAnimation.play("slide")
		$PlayerBanner1.play_activate_sound()
	else:
		$P1BannerAnimation.play_backwards("slide")
		$PlayerBanner1.play_deactivate_sound()
	ActivePlayersRepository.p1_toggle_active()


func p2_toggle_active():
	if !ActivePlayersRepository.p2_active:
		$P2BannerAnimation.play("slide")
		$PlayerBanner2.play_activate_sound()
	else:
		$P2BannerAnimation.play_backwards("slide")
		$PlayerBanner2.play_deactivate_sound()
	ActivePlayersRepository.p2_toggle_active()


func p3_toggle_active():
	if !ActivePlayersRepository.p3_active:
		$P3BannerAnimation.play("slide")
		$PlayerBanner3.play_activate_sound()
	else:
		$P3BannerAnimation.play_backwards("slide")
		$PlayerBanner3.play_deactivate_sound()
	ActivePlayersRepository.p3_toggle_active()
