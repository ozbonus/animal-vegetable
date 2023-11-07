extends Node

var p1_active: bool = false
var p2_active: bool = false
var p3_active: bool = false

func p1_toggle_active():
	p1_active = !p1_active

func p2_toggle_active():
	p2_active = !p2_active

func p3_toggle_active():
	p3_active = !p3_active

func reset():
	p1_active = false
	p2_active = false
	p3_active = false
