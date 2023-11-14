extends Node2D

signal mash_complete(value)
var mash_score: int = 0
var pops: Array[String] = [
	"res://audio/Popup1.wav",
	"res://audio/Popup2.wav",
	"res://audio/Popup3.wav",
	"res://audio/Popup4a.wav",
	"res://audio/Popup4b.wav",
]


func _ready():
	$Score/Label.text = "0"


func start_timer():
	$ArrowAnimator.play("rotate_arrow")
	$AppearSound.play()


func increase_mash_score() -> void:
	var rand_sound = pops[randi() % pops.size()]
	$AppearSound.stream = load(rand_sound)
	$AppearSound.play()
	mash_score += 1
	$Score/Label.text = str(mash_score)
	

func set_animation_scale(scale: float):
	$ArrowAnimator.speed_scale = scale



func _on_arrow_animator_animation_finished(anim_name):
	mash_complete.emit(mash_score)
	mash_score = 0
	$CompleteSound.play()
