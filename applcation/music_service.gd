extends Node


func play_title_music(delay := 0.0) -> void:
	_stop_gameplay_music()
	if !$TitleMusic.playing:
		await get_tree().create_timer(delay).timeout
		$TitleMusic.play()


func _stop_title_music() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($TitleMusic, "volume_db", -80.0, 2.0)
	tween.connect("finished", _on_stop_title_music_tween)


func _on_stop_title_music_tween() -> void:
	$TitleMusic.stop()
	$TitleMusic.volume_db = 0


func play_gameplay_music(delay := 0.0) -> void:
	_stop_title_music()
	if !$GameplayMusic.playing:
		await get_tree().create_timer(delay).timeout
		$GameplayMusic.play()


func _stop_gameplay_music() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($GameplayMusic, "volume_db", -80.0, 2.0)
	tween.connect("finished", _on_stop_gameplay_music_tween)


func _on_stop_gameplay_music_tween() -> void:
	$GameplayMusic.stop()
	$GameplayMusic.volume_db = 0
		
