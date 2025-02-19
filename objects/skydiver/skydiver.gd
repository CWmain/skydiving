extends Node2D

class_name skydiver

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var ascendSpeed: int = 100

func _physics_process(delta):

	# Add the gravity.
	var upDown = Input.get_axis("ui_up", "ui_down")
	if upDown:
		position.y += upDown * SPEED*delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		position.x += direction * SPEED * delta
	
	if position.y > 100:
		position.y += -ascendSpeed*delta
		
	if position.y < 100:
		position.y += ascendSpeed*delta
	
	# Limit plyaer movement to playable area 
	limitPlayerMovement()

func limitPlayerMovement():
	position.x = max(position.x, 0)
	position.x = min(position.x, 640)
	position.y = max(position.y, 0)
	position.y = min(position.y, 360)
