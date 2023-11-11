extends Node


var p1_age: int = 1
var p2_age: int = 1
var p3_age: int = 1
var p1_score: int = 0
var p2_score: int = 0
var p3_score: int = 0


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


func p1_set_age(age: int):
	p1_age = age
	print_age_message(1, age)


func p2_set_age(age: int):
	p2_age = age
	print_age_message(2, age)


func p3_set_age(age: int):
	p3_age = age
	print_age_message(3, age)


func add_p1_score(points: int):
	p1_score += points
	print_score_message(1, points, p1_score)


func add_p2_score(points: int):
	p2_score += points
	print_score_message(2, points, p2_score)


func add_p3_score(points: int):
	p3_score += points
	print_score_message(3, points, p3_score)


func reset_ages() -> void:
	p1_age = 0
	p2_age = 0
	p3_age = 0

func reset_scores() -> void:
	p1_score = 0
	p2_score = 0
	p3_score = 0

func reset():
	reset_ages()
	reset_scores()
	print("RESET: All scores are 1 and all scores are 0.")
