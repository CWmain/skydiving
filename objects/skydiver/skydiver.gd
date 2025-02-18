extends Node2D

class_name skydiver

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

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
	
	if position.y > 240:
		position.y += -90*delta

