extends SubViewportContainer

@export var GM: gameManager
@onready var animation_player = $SubViewport/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(GM != null)
	GM.introAnimation.connect(_playIntro)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _playIntro():
	animation_player.play("jumpFromPlane")

func _on_animation_player_animation_finished(anim_name):
	GM.inGame = true
