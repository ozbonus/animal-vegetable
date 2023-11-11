extends Node


var positions: Array
var cards: Array


func _ready():
	positions = [$Position1, $Position2, $Position3, $Position4, $Position5]

	deal_cards(4)
	
#	for p in positions:
#		var sprite = Sprite2D.new()
#		sprite.texture = preload("res://icon.svg")
#		sprite.position = p.position
#		add_child(sprite)
#		cards.append(sprite)
	
	for c in cards:
		print(c.name)
	
#	for p in positions:
#		var sprite = Sprite2D.new()
#		sprite.set_name('fnord')
#		var texture = preload("res://icon.svg")
#		sprite.textture = texture
#		sprite.position = p.position
#		add_child(sprite)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func deal_cards(count: int):
	assert(0 < count and count < 6)
	for p in positions.slice(0, count):
		var sprite := Sprite2D.new()
		sprite.texture = preload("res://icon.svg")
		sprite.position = p.position
		add_child(sprite)
		cards.append(sprite)
