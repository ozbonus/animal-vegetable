extends Node2D

var card_kind: Enums.Kind
var easy_cards: Array[String] = [
	"res://cards/ani01.png",
	"res://cards/ani02.png",
	"res://cards/ani03.png",
	"res://cards/ani04.png",
	"res://cards/veg01.png",
	"res://cards/veg02.png",
	"res://cards/veg03.png",
	"res://cards/veg04.png",
]
var hard_cards: Array[String] = [
	"res://cards/h_ani01.png",
	"res://cards/h_ani02.png",
	"res://cards/h_ani03.png",
	"res://cards/h_ani04.png",
	"res://cards/h_ani05.png",
	"res://cards/h_veg01.png",
	"res://cards/h_veg02.png",
	"res://cards/h_veg03.png",
	"res://cards/h_veg04.png",
	"res://cards/h_veg05.png",
]

signal correct
signal mistake
signal result


func _ready():
	hide()


func _process(delta):
	pass


func appear(index: int, difficult: bool=false) -> void:
	var random_texture: String
	
	if !difficult:
		random_texture = easy_cards[randi() % easy_cards.size()]
	else:
		random_texture = hard_cards[randi() % hard_cards.size()]
		
	if random_texture.contains("ani"):
		card_kind = Enums.Kind.animal
	else:
		card_kind = Enums.Kind.vegetable
	$Sprite.texture = load(random_texture)
	show()
	$AnimationPlayer.stop()
	await get_tree().create_timer(index * 0.05).timeout
	$AnimationPlayer.play("appear")


func answer(answer_kind: Enums.Kind) -> void:
	if answer_kind == card_kind:
		disappear_correct()
	else:
		disappear_mistake()


func disappear_correct() -> void:
	result.emit(1)
	$CorrectSound.play()
	$Coins.emitting = true
	$Coins.restart()
	$Notes.emitting = true
	$Notes.restart()
	$AnimationPlayer.play_backwards("appear")


func disappear_mistake() -> void:
	result.emit(0)
	$MistakeSound.play()
	$Explosion.emitting = true
	$Explosion.restart()
	$AnimationPlayer.play_backwards("appear")

