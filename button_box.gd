extends Node


enum State {STOP, REACTIVE, MASH, LEFT, RIGHT, AGE}
@export var state := State.REACTIVE
@export_enum("p1", "p2", "p3", "p4") var player_num: String = "p1"
@export_range(0.0, 2.0, 0.1) var age_delay: float = 0


func _ready():
	pass


func _process(delta):
	if state != State.MASH:
		[$LeftHand, $RightHand].map(func(x): x.hide())
	else:
		[$LeftHand, $RightHand].map(func(x): x.show())
	
	if state != State.AGE:
		[$Minus, $Plus].map(func(x): x.hide())
	else:
		[$Minus, $Plus].map(func(x): x.show())
		
	match state:
		State.STOP:
			$Left.play("up")
			$Right.play("up")
		State.REACTIVE:
			if Input.is_action_pressed("%s_left" % player_num):
				$Left.play("down")
			else:
				$Left.play("up")
			
			if Input.is_action_pressed("%s_right" % player_num):
				$Right.play("down")
			else:
				$Right.play("up")
		State.MASH:
			$Left.play("flutter")
			$Right.play("flutter")
		State.LEFT:
			$Left.play("down")
			$Right.play("up")
		State.RIGHT:
			$Left.play("up")
			$Right.play("down")
		State.AGE:
			if !$MinusAnimation.is_playing():
				$MinusAnimation.play("move")
				$MinusAnimation.seek(age_delay + 0.1)
				$PlusAnimation.play("move")
				$PlusAnimation.seek(age_delay)
			
			if Input.is_action_pressed("%s_left" % player_num):
				$Left.play("down")
			else:
				$Left.play("up")
			
			if Input.is_action_pressed("%s_right" % player_num):
				$Right.play("down")
			else:
				$Right.play("up")


func stop() -> void: state = State.STOP
func left_down() -> void: state = State.LEFT
func right_down() -> void: state = State.RIGHT
func reactive() -> void: state = State.REACTIVE
func mash() -> void: state = State.MASH
func age() -> void: state = State.AGE

