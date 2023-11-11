extends Node


var debug: bool = true
var p1_active: bool = ActivePlayersRepository.p1_active
var p2_active: bool = ActivePlayersRepository.p2_active
var p3_active: bool = ActivePlayersRepository.p3_active
var display_ages = {"P1": 6, "P2": 7, "P3": 8}



func _ready():
	if !p1_active and !debug:
		$P1Content.queue_free()
	if !p2_active and !debug:
		$P2Content.queue_free()
	if !p3_active and !debug:
		$P3Content.queue_free()
	
	if p1_active or debug:
		$P1Content/AgeLabel.text = str(display_ages["P1"])
	if p2_active or debug:
		$P2Content/AgeLabel.text = str(display_ages["P2"])
	if p3_active or debug:
		$P3Content/AgeLabel.text = str(display_ages["P3"])


func _process(delta):
	if Input.is_action_just_pressed("previous_screen"):
		ScreenTransition.change_screen("res://title_screen.tscn")
	
	if Input.is_action_just_pressed("next_screen"):
		PlayerRepository.p1_set_age(display_ages["P1"])
		PlayerRepository.p2_set_age(display_ages["P2"])
		PlayerRepository.p3_set_age(display_ages["P3"])
		ScreenTransition.change_screen("res://tutorial_screen.tscn")
	
	if p1_active or debug:
		if Input.is_action_just_pressed("p1_age_down"):
			change_display_age("P1", -1)
		if Input.is_action_just_pressed("p1_age_up"):
			change_display_age("P1", 1)

		if Input.is_action_pressed("p1_age_down"):
			$P1Content/ButtonBox.left_down()
		if Input.is_action_just_released("p1_age_down"):
			$P1Content/ButtonBox.left_up()
		if Input.is_action_pressed("p1_age_up"):
			$P1Content/ButtonBox.right_down()
		if Input.is_action_just_released("p1_age_up"):
			$P1Content/ButtonBox.right_up()

	if p2_active or debug:
		if Input.is_action_just_pressed("p2_age_down"):
			change_display_age("P2", -1)
		if Input.is_action_just_pressed("p2_age_up"):
			change_display_age("P2", 1)

		if Input.is_action_pressed("p2_age_down"):
			$P2Content/ButtonBox.left_down()
		if Input.is_action_just_released("p2_age_down"):
			$P2Content/ButtonBox.left_up()
		if Input.is_action_pressed("p2_age_up"):
			$P2Content/ButtonBox.right_down()
		if Input.is_action_just_released("p2_age_up"):
			$P2Content/ButtonBox.right_up()

	if p3_active or debug:
		if Input.is_action_just_pressed("p3_age_down"):
			change_display_age("P3", -1)
		if Input.is_action_just_pressed("p3_age_up"):
			change_display_age("P3", 1)
			
		if Input.is_action_pressed("p3_age_down"):
			$P3Content/ButtonBox.left_down()
		if Input.is_action_just_released("p3_age_down"):
			$P3Content/ButtonBox.left_up()
		if Input.is_action_pressed("p3_age_up"):
			$P3Content/ButtonBox.right_down()
		if Input.is_action_just_released("p3_age_up"):
			$P3Content/ButtonBox.right_up()


## `player_ref` must be "P1", "P2", or "P3".
func change_display_age(player_ref: String, value: int) -> void:
	assert(player_ref in ["P1", "P2", "P3"])
	var node_path_str = "%sContent" % player_ref
	var old_display_age: int = display_ages[player_ref]
	var new_display_age = clamp(display_ages[player_ref] + value, 4, 14)
	display_ages[player_ref] = new_display_age
	var age_label: Label = get_node("%sContent/AgeLabel" % player_ref)
	var animation: AnimationPlayer = get_node("%sContent/AgeLabelAnimation" % player_ref)
	if new_display_age == 14:
		age_label.text = "14+"
	else:
		age_label.text = str(new_display_age)
	animation.play("jiggle")
	print(player_ref, " ", old_display_age, " -> ", new_display_age)

