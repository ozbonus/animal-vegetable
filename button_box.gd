extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	left_up()
	right_up()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func left_down() -> void:
	$Left.play("down")

func left_up() -> void:
	$Left.play("up")

func right_down() -> void:
	$Right.play("down")

func right_up() -> void:
	$Right.play("up")

func flutter() -> void:
	$Left.play("flutter")
	$Right.play("flutter")
