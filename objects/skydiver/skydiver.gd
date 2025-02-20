extends Node2D

class_name skydiver

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var ascendSpeed: int = 100
@export var GM_HOLDER: SubViewportContainer

var GM: gameManager
var fallSpeed = 0
func _ready():
	GM = GM_HOLDER.GM
	assert(GM != null)
	GM.landOnGround.connect(_landing)

func _physics_process(delta):
	if GM.endGame and position.y < 360-GM.groundHeight:
		position.y += fallSpeed * delta
		GM.current_height -= fallSpeed * delta
		print("Postion: %s\nCurrent Height: %s" % [str(position), str(GM.current_height)] )
		return
	elif GM.endGame:
		position.y = 360-GM.groundHeight
		return

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
	
func _landing():
	fallSpeed = GM.current_speed
	GM.current_speed = 0
	GM.current_height -= position.y
	print("End the game")
