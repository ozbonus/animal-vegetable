extends Node


var time = 0
var timer_on = false
var presses: int = 0
var presses_per_second: int = 0


func _process(delta):
	if timer_on:
		time += delta


func start() -> void:
	timer_on = true


func stop() -> void:
	timer_on = false


func press() -> void:
	presses += 1
	presses_per_second = int(presses / time)
