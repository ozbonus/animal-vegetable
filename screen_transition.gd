extends CanvasLayer

@export_range(0.5, 4.0) var pause_time: float = 1.0

func change_screen(target: String) -> void:
	$ScreenTransitionAnimation.play("slide_in")
	await $ScreenTransitionAnimation.animation_finished
	await get_tree().create_timer(pause_time).timeout
	get_tree().change_scene_to_file(target)
	$ScreenTransitionAnimation.play("slide_out")
	
