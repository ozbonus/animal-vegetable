extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_p_1_toggle_active_button_pressed():
	if !ActivePlayersRepository.p1_active:
		$P1BannerAnimation.play("slide")
	else:
		$P1BannerAnimation.play_backwards("slide")
	ActivePlayersRepository.p1_toggle_active()


func _on_p_2_toggle_active_button_pressed():
	if !ActivePlayersRepository.p2_active:
		$P2BannerAnimation.play("slide")
	else:
		$P2BannerAnimation.play_backwards("slide")
	ActivePlayersRepository.p2_toggle_active()


func _on_p_3_toggle_active_button_pressed():
	if !ActivePlayersRepository.p3_active:
		$P3BannerAnimation.play("slide")
	else:
		$P3BannerAnimation.play_backwards("slide")
	ActivePlayersRepository.p3_toggle_active()
