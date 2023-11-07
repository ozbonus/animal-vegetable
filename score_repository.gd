extends Node

var p1_score: int = 0
var p2_score: int = 0
var p3_score: int = 0

func add_p1_score(points: int):
	p1_score += points
	
func add_p2_score(points: int):
	p2_score += points

func add_p3_score(points: int):
	p3_score += points

func reset():
	p1_score = 0
	p2_score = 0
	p3_score = 0
