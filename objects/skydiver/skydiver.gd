extends Node2D

class_name skydiver

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

enum PlayerState{
	Hidden,
	Falling,
	Safe,
	Injured,
	Splatter
}

@export var ascendSpeed: int = 100
@export var GM_HOLDER: SubViewportContainer
@export var playerState: PlayerState = PlayerState.Hidden: set = selectPlayerState

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
	GM.reset.connect(restartGame)

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
		
		GM.endScreen.emit()	
		print("wait, then end game displaying speed as a score")
	
	# Prevent all movement when screen locked for the end of the game
	if GM.lockScreen:
		return

	# Get the input direction and handle the movement/deceleration.
	var upDown = Input.get_axis("up", "down")
	var leftRight = Input.get_axis("left", "right")
	if leftRight > 0:
		falling_skydiver.flip_h = false
		injured_skydiver.flip_h = false
	if leftRight < 0:
		falling_skydiver.flip_h = true
		injured_skydiver.flip_h = true
		
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

func restartGame():
	falling_skydiver.show()
	safe_skydiver.hide()
	injured_skydiver.hide()
	splatter.hide()
	landed = false
	position = Vector2(320,100)

func selectPlayerState(state: PlayerState):
	if falling_skydiver == null:
		playerState = state
		return
	match state:
		PlayerState.Hidden:
			falling_skydiver.hide()
			safe_skydiver.hide()
			injured_skydiver.hide()
			splatter.hide()
		PlayerState.Falling:
			falling_skydiver.show()
			safe_skydiver.hide()
			injured_skydiver.hide()
			splatter.hide()
		PlayerState.Safe:
			safe_skydiver.show()
			falling_skydiver.hide()
			injured_skydiver.hide()
			splatter.hide()
		PlayerState.Injured:
			injured_skydiver.show()
			falling_skydiver.hide()
			safe_skydiver.hide()
			splatter.hide()
		PlayerState.Splatter:
			splatter.show()
			falling_skydiver.hide()
			safe_skydiver.hide()
			injured_skydiver.hide()
	playerState = state
