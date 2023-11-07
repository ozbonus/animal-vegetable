extends CanvasGroup

@export var banner: Texture2D
@export var player_number: String

# Called when the node enters the scene tree for the first time.
func _ready():
	$BannerSprite.texture = banner
	$PlayerNumber.text = player_number


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_activate_sound():
	$ActivateSound.play()

func play_deactivate_sound():
	$DeactivateSound.play()
