extends Node

enum Difficulty {easy1, easy2, easy3, easy4, easy5, hard1, hard2, hard3, hard4, hard5}
enum Mode {countdown, card, mash}

@export var age: int = 10 ## The age of the player. Debug use only here.
@export var age_difficulty_cap: int = 8 ## This age and lower only plays easy.
@export var base_card_points: int = 100 ## Points for one correct answer.
@export var card_age_bonus: int = 10 ## Bonus per year under 14.
@export var set_bonus: int = 200 ## Points for a perfect set of answers.
@export var starting_difficulty := Difficulty.easy1 ## Debug only.
@export_range(1, 10) var difficulty_up_interval: int = 3 ## Harder every n perfect sets.
@export_range(1, 10) var difficulty_down_interval: int = 1 ## Easier every n botched sets.


var positions: Array
var hand: Array
var cards: Array
var record: Array
var target: int = 0
var difficulty_level: Difficulty
var score: int = 0
var mode: Mode
var perfect_set_streak: int = 0
var failed_set_streak: int = 0
var need_cards: bool = true


func _ready():
	mode = Mode.card
	difficulty_level = starting_difficulty


func _process(delta):
	if mode == Mode.card:
		card_game_loop()
		
		
func card_game_loop() -> void:
	# Runs when there are no cards or the set of cards is complete.
	if need_cards:
		need_cards = false
		match difficulty_level:
			Difficulty.easy1:
				deal_set(1)
			Difficulty.easy2:
				deal_set(2)
			Difficulty.easy3:
				deal_set(3)
			Difficulty.easy4:
				deal_set(4)
			Difficulty.easy5:
				deal_set(5)
			Difficulty.hard1:
				deal_set(1, true)
			Difficulty.hard2:
				deal_set(2, true)
			Difficulty.hard3:
				deal_set(3, true)
			Difficulty.hard4:
				deal_set(4, true)
			Difficulty.hard5:
				deal_set(5, true)
		
	show_target_arrow(target)
	
	if Input.is_action_just_pressed("debug_animal") and target < cards.size():
		cards[target].answer(Enums.Kind.animal)
		target += 1
	
	if Input.is_action_just_pressed("debug_vegetable") and target < cards.size():
		cards[target].answer(Enums.Kind.vegetable)
		target += 1
	
	# Runs when the set of cards is complete.
	if target >= cards.size():
		maybe_congratulations()
		award_set_points()
		
		if record.count(0) == 0:
			perfect_set_streak += 1
		else: perfect_set_streak = 0
		
		if record.count(0) > record.count(1):
			failed_set_streak += 1
		else:
			failed_set_streak = 0

		if perfect_set_streak % difficulty_up_interval == 0 and perfect_set_streak != 0:
			increase_difficulty()
			
		if failed_set_streak % difficulty_down_interval == 0 and failed_set_streak != 0:
			decrease_difficulty()
		
		print(score)
		record.clear()
		cards.clear()
		target = 0
		need_cards = true



func mash_game_loop() -> void:
	pass


func deal_set(count: int, difficult: bool=false):
	assert(0 < count and count < 6)
	var index := 0
	for card in [$Card1, $Card2, $Card3, $Card4, $Card5].slice(0, count):
		card.appear(index, difficult)
		cards.append(card)
		index += 1


func show_target_arrow(index: int):
	$TargetArrows.get_children().map(func(x): x.hide())
	$TargetArrows.get_children()[index].show()


func award_card_points(value: int) -> void:
	var points: int = value * base_card_points
	var bonus: int = card_age_bonus * (14 - age)
	score += points + bonus


func award_set_points() -> void:
	if record.count(0) == 0:
		score += set_bonus * (difficulty_level + 1)


func maybe_congratulations() -> void:
	if record.count(0) == 0:
		var messages: Array[String] = [
			"res://art/message_fantastic.png",
			"res://art/message_good_job.png",
			"res://art/message_well_done.png"
		]
		var random_message = messages[randi() % messages.size()]
		var random_rotation: float = randf_range(-10, 10)
		$Congrats.rotate(deg_to_rad(0))
		$Congrats.rotate(deg_to_rad(random_rotation))
		$Congrats.texture = load(random_message)
		$CongratsAnimation.play("show")
		$CongratsSound.play()


func increase_difficulty() -> void:
	var max_difficulty: int = Difficulty.hard5
	if age <= age_difficulty_cap:
		max_difficulty = Difficulty.easy5
	var new_difficulty: int = clamp(difficulty_level + 1, 0, max_difficulty)
	difficulty_level = new_difficulty


func decrease_difficulty() -> void:
	var new_difficulty: int = clamp(difficulty_level - 1, 0, 9)
	difficulty_level = new_difficulty


func _on_card_1_result(value: int):
	record.append(value)
	award_card_points(value)


func _on_card_2_result(value: int):
	record.append(value)
	award_card_points(value)


func _on_card_3_result(value: int):
	record.append(value)
	award_card_points(value)


func _on_card_4_result(value: int):
	record.append(value)
	award_card_points(value)
	

func _on_card_5_result(value: int):
	record.append(value)
	award_card_points(value)
