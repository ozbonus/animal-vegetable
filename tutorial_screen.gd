extends Node

var cards_1: Array[Node] = [$P1Area/Card1, $P2Area/Card1, $P2Area/Card1, $P2Area/Card1]
var cards_2: Array[Node] = [$P1Area/Card2, $P2Area/Card2, $P2Area/Card2, $P2Area/Card2]
var cards_3: Array[Node] = [$P1Area/Card3, $P2Area/Card3, $P2Area/Card3, $P2Area/Card3]
var cards_4: Array[Node] = [$P1Area/Card4, $P2Area/Card4, $P2Area/Card4, $P2Area/Card4]
var arrows_1: Array[Node] = [
	$P1Area/TargetArrows/TargetArrow1,
	$P2Area/TargetArrows/TargetArrow1,
	$P3Area/TargetArrows/TargetArrow1,
	$P4Area/TargetArrows/TargetArrow1,
]
var arrows_2: Array[Node] = [
	$P1Area/TargetArrows/TargetArrow2,
	$P2Area/TargetArrows/TargetArrow2,
	$P3Area/TargetArrows/TargetArrow2,
	$P4Area/TargetArrows/TargetArrow2,
]
var arrows_3: Array[Node] = [
	$P1Area/TargetArrows/TargetArrow3,
	$P2Area/TargetArrows/TargetArrow3,
	$P3Area/TargetArrows/TargetArrow3,
	$P4Area/TargetArrows/TargetArrow3,
]
var arrows_4: Array[Node] = [
	$P1Area/TargetArrows/TargetArrow4,
	$P2Area/TargetArrows/TargetArrow4,
	$P3Area/TargetArrows/TargetArrow4,
	$P4Area/TargetArrows/TargetArrow4,
]



func _ready():
	MusicService.play_title_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("next_screen"):
		ScreenTransition.change_screen("res://play_screen.tscn")
	if Input.is_action_just_pressed("previous_screen"):
		ScreenTransition.change_screen("res://age_screen.tscn")
	if Input.is_action_just_pressed("p1_left"):
		$Card.disappear_correct()
