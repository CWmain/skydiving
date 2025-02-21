extends Node2D

class_name skydiver

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var ascendSpeed: int = 100
@export var GM_HOLDER: SubViewportContainer

## Skydiver graphics
@onready var falling_skydiver = $FallingSkydiver
@onready var safe_skydiver = $SafeSkydiver
@onready var injured_skydiver = $InjuredSkydiver
@onready var splatter = $Splatter

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
	
	# Occurs when we first land due to elif with above statement
	elif GM.lockScreen and !landed:
		position.y = 360-GM.groundHeight
		landed = true
		var percentSpeed = (float(GM.lastSpeed-GM.minSpeed)/float(GM.startingSpeed))
		falling_skydiver.hide()
		if (percentSpeed > GM.percentSplatter):
			splatter.show()
			print("Splatter")
		elif (percentSpeed > GM.percentInjured):
			injured_skydiver.show()
			print("Injured")
		else:
			print("Safe")
			safe_skydiver.show()
		print("wait, then end game displaying speed as a score")
	
	# Prevent all movement when screen locked for the end of the game
	if GM.lockScreen:
		return

	# Get the input direction and handle the movement/deceleration.
	var upDown = Input.get_axis("up", "down")
	var leftRight = Input.get_axis("left", "right")
	position += Vector2(leftRight, upDown).normalized()*SPEED*delta
	
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
	position.y = min(position.y, 320)
	
func _landing():	
	# Adjust the current height with the characters height from floor
	GM.current_height -= position.y
