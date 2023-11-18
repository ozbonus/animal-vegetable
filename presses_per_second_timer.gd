extends Node


var time = 0
var timer_on = false
var presses: int = 0
var presses_per_second: float = 0


func _process(delta):
	if timer_on:
		time += delta


func start() -> void:
	timer_on = true


func stop() -> void:
	timer_on = false


func reset() -> void:
	time = 0
	presses = 0
	presses_per_second = 0


func stop_and_reset() -> void:
	stop()
	reset()


func press() -> void:
	presses += 1
	if time > 0:
		presses_per_second = presses / time
