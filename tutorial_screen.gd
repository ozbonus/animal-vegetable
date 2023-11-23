extends Node


enum State {ANIMAL_1, ANIMAL_2, VEG_1, VEG_2, MASH}
enum Substate {NOT_READY, IN_PROGRESS, FINISHED}



var p1_active: bool = ActivePlayersRepository.p1_active
var p2_active: bool = ActivePlayersRepository.p2_active
var p3_active: bool = ActivePlayersRepository.p3_active
var p4_active: bool = ActivePlayersRepository.p4_active
var cards_1: Array[Node]
var cards_2: Array[Node]
var cards_3: Array[Node]
var cards_4: Array[Node]
var arrows_1: Array[Node]
var arrows_2: Array[Node]
var mash_visuals: Array[Node]
var button_boxes: Array[Node]
var congrates_sprites: Array[Node]
var congrats_animation: Array[Node]
var p1_done := false
var p2_done := false
var p3_done := false
var p4_done := false
var state := State.ANIMAL_1
var animal_1_state: Substate = Substate.NOT_READY
var animal_2_state: Substate = Substate.NOT_READY
var veg_1_state: Substate = Substate.NOT_READY
var veg_2_state: Substate = Substate.NOT_READY
var mash_state: Substate = Substate.NOT_READY



func _ready():
	cards_1 = [$P1Area/Card1, $P2Area/Card1, $P3Area/Card1, $P4Area/Card1]
	cards_2 = [$P1Area/Card2, $P2Area/Card2, $P3Area/Card2, $P4Area/Card2]
	cards_3 = [$P1Area/Card3, $P2Area/Card3, $P3Area/Card3, $P4Area/Card3]
	cards_4 = [$P1Area/Card4, $P2Area/Card4, $P3Area/Card4, $P4Area/Card4]
	arrows_1 = [
		$P1Area/TargetArrows/TargetArrow1,
		$P2Area/TargetArrows/TargetArrow1,
		$P3Area/TargetArrows/TargetArrow1,
		$P4Area/TargetArrows/TargetArrow1,
	]
	arrows_2 = [
		$P1Area/TargetArrows/TargetArrow2,
		$P2Area/TargetArrows/TargetArrow2,
		$P3Area/TargetArrows/TargetArrow2,
		$P4Area/TargetArrows/TargetArrow2,
	]
	mash_visuals = [
		$P1Area/MashVisuals,
		$P2Area/MashVisuals,
		$P3Area/MashVisuals,
		$P4Area/MashVisuals,
	]
	button_boxes = [
		$P1Area/ButtonBox,
		$P2Area/ButtonBox,
		$P3Area/ButtonBox,
		$P4Area/ButtonBox,
	]
	congrates_sprites = [
		$P1Area/Congrats,
		$P2Area/Congrats,
		$P3Area/Congrats,
		$P4Area/Congrats,
	]
	congrats_animation = [
		$P1Area/CongratsAnimation,
		$P2Area/CongratsAnimation,
		$P3Area/CongratsAnimation,
		$P4Area/CongratsAnimation,
	]

	MusicService.play_title_music()
	mash_visuals.map(func(x): x.hide())
	
	
	if !p1_active:
		$P1Area.hide()
	if !p2_active:
		$P2Area.hide()
	if !p3_active:
		$P3Area.hide()
	if !p4_active:
		$P4Area.hide()


func _process(delta):
	if Input.is_action_just_pressed("next_screen"):
		ScreenTransition.change_screen("res://play_screen.tscn")
	if Input.is_action_just_pressed("previous_screen"):
		ScreenTransition.change_screen("res://age_screen.tscn")
	
	match state:
		State.ANIMAL_1:
			animal_1()
		State.VEG_1:
			veg_1()
		State.ANIMAL_2:
			animal_2()
		State.VEG_2:
			veg_2()
		State.MASH:
			mash()


func animal_1() -> void:
	match animal_1_state:
		Substate.NOT_READY:
			arrows_1.map(func(x): x.show())
			arrows_2.map(func(x): x.hide())
			button_boxes.map(func (x): x.tutorial_left())
			cards_1.map(func(x): x.show_tutorial_animal_1())
			animal_1_state = Substate.IN_PROGRESS
		Substate.IN_PROGRESS:
			if Input.is_action_just_pressed("p1_left") and !p1_done:
				cards_1[0].disappear_correct()
				arrows_1[0].hide()
				p1_done = true
			if Input.is_action_just_pressed("p2_left") and !p2_done:
				cards_1[1].disappear_correct()
				arrows_1[1].hide()
				p2_done = true
			if Input.is_action_just_pressed("p3_left") and !p3_done:
				cards_1[2].disappear_correct()
				arrows_1[2].hide()
				p3_done = true
			if Input.is_action_just_pressed("p4_left") and !p4_done:
				cards_1[3].disappear_correct()
				arrows_1[3].hide()
				p4_done = true
			if Input.is_action_just_pressed("ui_text_caret_right"):
				_show_congrats()
				state = State.VEG_1


func veg_1() -> void:
	match veg_1_state:
		Substate.NOT_READY:
			arrows_1.map(func(x): x.show())
			arrows_2.map(func(x): x.hide())
			button_boxes.map(func (x): x.tutorial_right())
			cards_1.map(func(x): x.show_tutorial_vegetable_1())
			_set_all_not_done()
			veg_1_state = Substate.IN_PROGRESS
		Substate.IN_PROGRESS:
			if Input.is_action_just_pressed("p1_right") and !p1_done:
				cards_1[0].disappear_correct()
				arrows_1[0].hide()
				p1_done = true
			if Input.is_action_just_pressed("p2_right") and !p2_done:
				cards_1[1].disappear_correct()
				arrows_1[1].hide()
				p2_done = true
			if Input.is_action_just_pressed("p3_right") and !p3_done:
				cards_1[2].disappear_correct()
				arrows_1[2].hide()
				p3_done = true
			if Input.is_action_just_pressed("p4_right") and !p4_done:
				cards_1[3].disappear_correct()
				arrows_1[3].hide()
				p4_done = true
			if Input.is_action_just_pressed("ui_text_caret_right"):
				_show_congrats()
				state = State.ANIMAL_2


func animal_2() -> void:
	match animal_2_state:
		Substate.NOT_READY:
			arrows_1.map(func(x): x.show())
			arrows_2.map(func(x): x.hide())
			button_boxes.map(func (x): x.tutorial_left())
			cards_1.map(func(x): x.show_tutorial_animal_2())
			cards_2.map(func(x): x.show_tutorial_vegetable_2())
			_set_all_not_done()
			animal_2_state = Substate.IN_PROGRESS
		Substate.IN_PROGRESS:
			if Input.is_action_just_pressed("p1_left") and !p1_done:
				cards_1[0].disappear_correct()
				arrows_1[0].hide()
				p1_done = true
			if Input.is_action_just_pressed("p2_left") and !p2_done:
				cards_1[1].disappear_correct()
				arrows_1[1].hide()
				p2_done = true
			if Input.is_action_just_pressed("p3_left") and !p3_done:
				cards_1[2].disappear_correct()
				arrows_1[2].hide()
				p3_done = true
			if Input.is_action_just_pressed("p4_left") and !p4_done:
				cards_1[3].disappear_correct()
				arrows_1[3].hide()
				p4_done = true
			if Input.is_action_just_pressed("ui_text_caret_right"):
				state = State.VEG_2


func veg_2() -> void:
	match veg_2_state:
		Substate.NOT_READY:
			arrows_1.map(func(x): x.hide())
			arrows_2.map(func(x): x.show())
			button_boxes.map(func (x): x.tutorial_right())
			_set_all_not_done()
			veg_2_state = Substate.IN_PROGRESS
		Substate.IN_PROGRESS:
			if Input.is_action_just_pressed("p1_right") and !p1_done:
				cards_2[0].disappear_correct()
				arrows_2[0].hide()
				p1_done = true
			if Input.is_action_just_pressed("p2_right") and !p2_done:
				cards_2[1].disappear_correct()
				arrows_2[1].hide()
				p2_done = true
			if Input.is_action_just_pressed("p3_right") and !p3_done:
				cards_2[2].disappear_correct()
				arrows_2[2].hide()
				p3_done = true
			if Input.is_action_just_pressed("p4_right") and !p4_done:
				cards_2[3].disappear_correct()
				arrows_2[3].hide()
				p4_done = true
			if Input.is_action_just_pressed("ui_text_caret_right"):
				_show_congrats()
				state = State.MASH


func mash() -> void:
	match mash_state:
		Substate.NOT_READY:
			button_boxes.map(func(x): x.mash())
			mash_visuals.map(func(x): x.show())
			mash_visuals.map(func(x): x.start_mock_timer())
			mash_state = Substate.IN_PROGRESS
		Substate.IN_PROGRESS:
			if Input.is_action_just_pressed("p1_left") \
			or Input.is_action_just_pressed("p1_right"):
				mash_visuals[0].increase_mash_score()
			if Input.is_action_just_pressed("p2_left") \
			or Input.is_action_just_pressed("p2_right"):
				mash_visuals[1].increase_mash_score()
			if Input.is_action_just_pressed("p3_left") \
			or Input.is_action_just_pressed("p3_right"):
				mash_visuals[2].increase_mash_score()
			if Input.is_action_just_pressed("p4_left") \
			or Input.is_action_just_pressed("p4_right"):
				mash_visuals[3].increase_mash_score()



func _show_congrats() -> void:
	var messages: Array[String] = [
	"res://art/message_fantastic.png",
	"res://art/message_good_job.png",
	"res://art/message_well_done.png"
]
	for congrats in congrates_sprites:
		var random_message = messages[randi() % messages.size()]
		var random_rotation: float = randf_range(-10, 10)
		congrats.rotate(deg_to_rad(0))
		congrats.rotate(deg_to_rad(random_rotation))
		congrats.texture = load(random_message)
	congrats_animation.map(func(x): x.play("show"))
	$CongratsSound.play()


func _set_all_not_done() -> void:
	p1_done = false
	p2_done = false
	p3_done = false
	p4_done = false
