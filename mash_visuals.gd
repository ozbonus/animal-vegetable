extends Node2D

signal mash_complete(value)
var mash_score: int = 0


func _ready():
	$Score/Label.text = "0"


func start_timer():
	$ArrowAnimator.play("rotate_arrow")


func increase_mash_score() -> void:
	mash_score += 1
	$Score/Label.text = str(mash_score)
	

func set_animation_scale(scale: float):
	$ArrowAnimator.speed_scale = scale




func _on_arrow_animator_animation_finished(anim_name):
	mash_complete.emit(mash_score)
	mash_score = 0
