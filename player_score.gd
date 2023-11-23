extends Node2D

signal finished

@export_category("Debug")
@export var debug: bool = false
@export var wait_time: float = 5.0
@export_category("Settings")
@export_range(0, 100) var tick_rate: int = 0

var proportion: float
var score: int
var tick: int = 1


func _ready():
	$Label.text = "$0"
	
	if debug:
		start(wait_time, 20000)


func _process(delta):
	if !$Timer.is_stopped() and tick % tick_rate == 0:
		var timer_proportion_complete: float = $Timer.time_left / $Timer.wait_time
		var score_proportion = (1 - timer_proportion_complete) * score
		var score_text := num_separator(int(score_proportion))
		$Label.text = "$%s" % score_text
	tick += 1


func start(wait_time: float, score: int) -> void:
	self.score = score
	$Timer.start(wait_time)


func num_separator(number:int) -> String:
	var string := str(number)
	var modulo = string.length() % 3 # 5000 ~ 1
	var result := ""
	
	for index in range(0, string.length()):
		if index != 0 and index % 3 == modulo:
			result += ","
		result += string[index]
	
	return result


func _on_timer_timeout():
	$Label.text = "$%s" % num_separator(int(score))
	[$Starburst1, $Starburst2, $Starburst3].map(func(x): x.emitting = true)
	[$Starburst1, $Starburst2, $Starburst3].map(func(x): x.restart())
	$FinishedSound.play()
	finished.emit()
