extends Node

var p1_score: int = 0
var p2_score: int = 0
var p3_score: int = 0
var points_msg: String = "Player {p} got {n} points. Total: {N}"

func add_p1_score(points: int):
	p1_score += points
	print(points_msg.format({
		"p": "1",
		"n": str(points),
		"N": str(p1_score),
	}))
	
func add_p2_score(points: int):
	p2_score += points
	print(points_msg.format({
		"p": "2",
		"n": str(points),
		"N": str(p2_score),
	}))

func add_p3_score(points: int):
	p3_score += points
	print(points_msg.format({
		"p": "3",
		"n": str(points),
		"N": str(p3_score),
	}))

func reset():
	p1_score = 0
	p2_score = 0
	p3_score = 0
	print("RESET: All scores are 0.")
