extends Node2D

var GM: gameManager

func _ready():
	GM = get_parent().GM
	assert(GM != null, "No parent for ground")
	position.y = 360

func _physics_process(delta):
	position.y += -GM.current_speed*delta
	if (GM.current_speed == 0):
		position.y = 360-GM.groundHeight
