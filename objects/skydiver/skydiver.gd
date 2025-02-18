extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta):
	print(position)
	# Add the gravity.
	var upDown = Input.get_axis("ui_up", "ui_down")
	if upDown:
		velocity.y = upDown * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if position.y > 240:
		velocity.y += -90
	move_and_slide()
