extends Node2D

class_name skydiver

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var ascendSpeed: int = 100
@export var GM_HOLDER: SubViewportContainer

var landed: bool = false
var GM: gameManager
var fallSpeed = 0

func _ready():
	GM = GM_HOLDER.GM
	assert(GM != null)
	GM.landOnGround.connect(_landing)

func _physics_process(delta):
	if GM.lockScreen and position.y < 360-GM.groundHeight:
		position.y += GM.lastSpeed * delta
		GM.current_height -= GM.lastSpeed * delta
		#print("Postion: %s\nCurrent Height: %s" % [str(position), str(GM.current_height)] )
		
	elif GM.lockScreen and !landed:
		position.y = 360-GM.groundHeight
		landed = true
		var percentSpeed = (float(GM.lastSpeed-GM.minSpeed)/float(GM.startingSpeed))
		if (percentSpeed > GM.percentSplatter):
			print("Splatter")
		elif (percentSpeed > GM.percentInjured):
			print("Injured")
		else:
			print("Safe")
		print("wait, then end game displaying speed as a score")
	
	# Prevent all movement when screen locked for the end of the game
	if GM.lockScreen:
		return

	# Add the gravity.
	var upDown = Input.get_axis("up", "down")
	if upDown:
		position.y += upDown * SPEED*delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var leftRight = Input.get_axis("left", "right")
	if leftRight:
		position.x += leftRight * SPEED * delta
	
	if position.y > 100:
		position.y += -ascendSpeed*delta
		
	if position.y < 100:
		position.y += ascendSpeed*delta
	
	# Limit plyaer movement to playable area 
	limitPlayerMovement()

func limitPlayerMovement():
	position.x = max(position.x, 16)
	position.x = min(position.x, 624)
	position.y = max(position.y, 16)
	position.y = min(position.y, 360)
	
func _landing():	
	# Adjust the current height with the characters height from floor
	GM.current_height -= position.y
