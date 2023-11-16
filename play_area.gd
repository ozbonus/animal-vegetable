extends Node2D


enum Difficulty {
	EASY_1, EASY_2, EASY_3, EASY_4, EASY_5,
	MEDI_1, MEDI_2, MEDI_3, MEDI_4, MEDI_5,
	HARD_1, HARD_2, HARD_3, HARD_4, HARD_5
}
enum Mode {COUNTDOWN, CARD, MASH, MASH_COOLDOWN}



@export var debug: bool = false
@export var age: int = 10 ## The age of the player. Debug use only here.
@export var easy_difficulty_cap: int = 8 ## This age and lower only plays easy.
@export var medium_difficulty_cap: int = 10 ## This age is limited to medium.
@export var base_card_points: int = 100 ## Points for one correct answer.
@export var card_age_bonus: int = 10 ## Bonus per year under 14.
@export var set_bonus: int = 200 ## Points for a perfect set of answers.
@export var starting_difficulty := Difficulty.EASY_1 ## Debug only.
@export_range(1, 10) var difficulty_up_interval: int = 3 ## Harder every n perfect sets.
@export_range(1, 10) var difficulty_down_interval: int = 1 ## Easier every n botched sets.
@export_enum("p1", "p2", "p3", "p4") var player_num: String = "p1"
@export var mash_interval: int = 3 ## Mash minigame every n perfect sets.
@export var mash_multiplier: int = 10 ## Points awards per point of mash score.


var p1_active: bool = ActivePlayersRepository.p1_active
var p2_active: bool = ActivePlayersRepository.p2_active
var p3_active: bool = ActivePlayersRepository.p3_active
var p4_active: bool = ActivePlayersRepository.p4_active


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
var need_mode_setup = true


func _ready():
	mode = Mode.CARD
	difficulty_level = starting_difficulty
	if debug:
		pass
	else:
		match player_num:
			"p1":
				age = PlayerRepository.p1_age
			"p2":
				age = PlayerRepository.p2_age
			"p3":
				age = PlayerRepository.p3_age
			"p4":
				age = PlayerRepository.p4_age
			
			
func _process(delta):
	if mode == Mode.COUNTDOWN:
		countdown_loop()
	if mode == Mode.CARD:
		card_game_loop()
	if mode == Mode.MASH:
		mash_game_loop()
	if mode == Mode.MASH_COOLDOWN:
		mash_cooldown_loop()


func countdown_loop():
	$TargetArrows.hide()
	$ButtonBox.stop()
	$MashVisuals.hide()
	if Input.is_anything_pressed():
		pass
		
		
func card_game_loop() -> void:
	if need_mode_setup:
		$MashVisuals.hide()
		$ButtonBox.reactive()
		$TargetArrows.show()
		need_mode_setup = false
		
	# Runs when there are no cards or the set of cards is complete.
	if need_cards:
		need_cards = false
		match difficulty_level:
			Difficulty.EASY_1:
				deal_set(1)
			Difficulty.EASY_2:
				deal_set(2)
			Difficulty.EASY_3:
				deal_set(3)
			Difficulty.EASY_4:
				deal_set(4)
			Difficulty.EASY_5:
				deal_set(5)
			Difficulty.MEDI_1:
				deal_set(1, true, false)
			Difficulty.MEDI_2:
				deal_set(2, true, false)
			Difficulty.MEDI_3:
				deal_set(3, true, false)
			Difficulty.MEDI_4:
				deal_set(4, true, false)
			Difficulty.MEDI_5:
				deal_set(5, true, false)			
			Difficulty.HARD_1:
				deal_set(1, false, true)
			Difficulty.HARD_2:
				deal_set(2, false, true)
			Difficulty.HARD_3:
				deal_set(3, false, true)
			Difficulty.HARD_4:
				deal_set(4, false, true)
			Difficulty.HARD_5:
				deal_set(5, false, true)
		
	show_target_arrow(target)
	
	if Input.is_action_just_pressed("%s_left" % player_num) and target < cards.size():
		cards[target].answer(Enums.Kind.animal)
		target += 1
	
	if Input.is_action_just_pressed("%s_right" % player_num) and target < cards.size():
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
		
		record.clear()
		cards.clear()
		target = 0
		need_cards = true
		
		if perfect_set_streak % mash_interval == 0 and perfect_set_streak != 0:
			need_mode_setup = true
			mode = Mode.MASH



func mash_game_loop() -> void:
	if need_mode_setup:
		$TargetArrows.hide()
		$ButtonBox.mash()
		$MashVisuals.show()
		$MashVisuals.start_timer()
		need_mode_setup = false
	[$Card1, $Card2, $Card3, $Card4, $Card5].map(func (x): x.hide())
	if Input.is_action_just_pressed("%s_left" % player_num):
		$MashVisuals.increase_mash_score()
	if Input.is_action_just_pressed("%s_right" % player_num):
		$MashVisuals.increase_mash_score()


func mash_cooldown_loop() -> void:
	if need_mode_setup:
		$MashVisuals.hide()
		$ButtonBox.reactive()
		need_mode_setup = false
	if $MashCoolDownTimer.time_left > 0:
		pass
	else:
		$MashCoolDownTimer.start()


func deal_set(count: int, medium := false, difficult := false):
	assert(0 < count and count < 6)
	var index := 0
	for card in [$Card1, $Card2, $Card3, $Card4, $Card5].slice(0, count):
		card.appear(index, medium, difficult)
		cards.append(card)
		index += 1


func show_target_arrow(index: int):
	$TargetArrows.get_children().map(func(x): x.hide())
	$TargetArrows.get_children()[index].show()


func award_card_points(value: int) -> void:
	var points: int = value * base_card_points
	var bonus: int = card_age_bonus * (14 - age)
	match player_num:
		"p1":
			PlayerRepository.add_p1_points(points)
		"p2":
			PlayerRepository.add_p2_points(points)
		"p3":
			PlayerRepository.add_p3_points(points)
		"p4":
			PlayerRepository.add_p4_points(points)
	score += points + bonus


func award_set_points() -> void:
	if record.count(0) == 0:
		match player_num:
			"p1":
				PlayerRepository.add_p1_points(set_bonus)
			"p2":
				PlayerRepository.add_p2_points(set_bonus)
			"p3":
				PlayerRepository.add_p3_points(set_bonus)
			"p4":
				PlayerRepository.add_p4_points(set_bonus)


func award_mash_points(value: int) -> void:
	var points: int = value * mash_multiplier
	match player_num:
		"p1":
			PlayerRepository.add_p1_points(points)
		"p2":
			PlayerRepository.add_p2_points(points)
		"p3":
			PlayerRepository.add_p3_points(points)
		"p4":
			PlayerRepository.add_p4_points(points)


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
	var max_difficulty: int = Difficulty.HARD_5
	if age <= easy_difficulty_cap:
		max_difficulty = Difficulty.EASY_5
	elif age <= medium_difficulty_cap:
		max_difficulty = Difficulty.MEDI_5
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


func _on_mash_visuals_mash_complete(mash_score):
	print("Mash Score: ", mash_score)
	award_mash_points(mash_score)
	$CongratsAnimation.play("show")
	$MashCoins.amount = mash_score
	$MashCoins.emitting = true
	$MashCoins.restart()
	mode = Mode.MASH_COOLDOWN


func _on_mash_cool_down_timer_timeout():
	need_mode_setup = true
	mode = Mode.CARD