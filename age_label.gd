extends Node2D


@export var default_age: int = 8
@export var max_age: int = 14
var age: int
var random_age: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	scramble()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func adjust_age(value: int) -> void:
	age = clamp(age + value, 5, 14)
	
	if age == 14:
		$CenterContainer/Label.text = "14+"
	else:
		$CenterContainer/Label.text = str(age)
	
	$AnimationPlayer.play("jiggle")
	
	if value > 0:
		$AgeUpSound.play()
	else:
		$AgeDownSound.play()
		

func scramble() -> void:
	$ScrambleTimer.start()
	$ScrambleSubTimer.start()


func _on_scramble_timer_timeout():
	$ScrambleSubTimer.stop()
	age = default_age
	$CenterContainer/Label.text = str(age)


func _on_scramble_sub_timer_timeout():
	var new_random_age: int = randi_range(1, 9)
	while new_random_age == random_age:
		new_random_age = randi_range(1, 9)
	random_age = new_random_age
	$CenterContainer/Label.text = str(random_age)
