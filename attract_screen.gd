extends CanvasLayer


func _ready():
	ActivePlayersRepository.reset()
	ScoreRepository.reset()
	$P1BannerAnimation.play("RESET")
	$P2BannerAnimation.play("RESET")
	$P3BannerAnimation.play("RESET")


func _on_p_1_toggle_active_button_pressed():
	if !ActivePlayersRepository.p1_active:
		$P1BannerAnimation.play("slide")
		$PlayerBanner1.play_activate_sound()
	else:
		$P1BannerAnimation.play_backwards("slide")
		$PlayerBanner1.play_deactivate_sound()
	ActivePlayersRepository.p1_toggle_active()


func _on_p_2_toggle_active_button_pressed():
	if !ActivePlayersRepository.p2_active:
		$P2BannerAnimation.play("slide")
		$PlayerBanner2.play_activate_sound()
	else:
		$P2BannerAnimation.play_backwards("slide")
		$PlayerBanner2.play_deactivate_sound()
	ActivePlayersRepository.p2_toggle_active()


func _on_p_3_toggle_active_button_pressed():
	if !ActivePlayersRepository.p3_active:
		$P3BannerAnimation.play("slide")
		$PlayerBanner3.play_activate_sound()
	else:
		$P3BannerAnimation.play_backwards("slide")
		$PlayerBanner3.play_deactivate_sound()
	ActivePlayersRepository.p3_toggle_active()
