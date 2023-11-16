extends Node


var p1_age: int = 8
var p2_age: int = 8
var p3_age: int = 8
var p4_age: int = 8
var p1_score: int = 0
var p2_score: int = 0
var p3_score: int = 0
var p4_score: int = 0


func print_age_message(player: int, age: int):
	print("Player {player} is {age} years old.".format({
		"player": str(player),
		"age": str(age),
	}))


func print_score_message(player: int, points: int, total: int):
	print("Player {player} got {points} points. Total: {total}".format({
		"player": str(player),
		"points": str(points),
		"total": str(total),
	}))


func p1_adjust_age(value: int):
	p1_age = clamp(p1_age + value, 5, 14)
	print("Player 1 age: %s" % p1_age)


func p2_adjust_age(value: int):
	p2_age = clamp(p2_age + value, 5, 14)
	print("Player 2 age: %s" % p2_age)


func p3_adjust_age(value: int):
	p3_age = clamp(p3_age + value, 5, 14)
	print("Player 3 age: %s" % p3_age)

func p4_adjust_age(value: int):
	p4_age = clamp(p4_age + value, 5, 14)
	print("Player 4 age: %s" % p4_age)


func add_p1_points(points: int):
	p1_score += points
	print_score_message(1, points, p1_score)


func add_p2_points(points: int):
	p2_score += points
	print_score_message(2, points, p2_score)


func add_p3_points(points: int):
	p3_score += points
	print_score_message(3, points, p3_score)


func add_p4_points(points: int):
	p4_score += points
	print_score_message(4, points, p4_score)


func reset_ages() -> void:
	p1_age = 8
	p2_age = 8
	p3_age = 8
	p4_age = 8
	print("RESET (AGE): All ages are 8.")

func reset_scores() -> void:
	p1_score = 0
	p2_score = 0
	p3_score = 0
	p4_score = 0
	print("RESET (SCORE): All scores are 0.")

func reset():
	reset_ages()
	reset_scores()
	print("RESET: All ages are 8 and all scores are 0.")
