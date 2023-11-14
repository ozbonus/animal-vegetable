extends Node


var p1_active: bool = false
var p2_active: bool = false
var p3_active: bool = false
var p4_active: bool = false


func p1_toggle_active() -> void:
	p1_active = !p1_active
	print("Player 1 active: ", p1_active)


func p2_toggle_active() -> void:
	p2_active = !p2_active
	print("Player 2 active: ", p2_active)


func p3_toggle_active() -> void:
	p3_active = !p3_active
	print("Player 3 active: ", p3_active)


func p4_toggle_active() -> void:
	p4_active = !p4_active
	print("Player 4 active: ", p4_active)


func reset():
	p1_active = false
	p2_active = false
	p3_active = false
	p4_active = false
	print("RESET: All players are inactive.")
