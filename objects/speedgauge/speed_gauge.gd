extends Control

@export var GM: gameManager

# The skydiver speed needs to be expressed from the max value to 1 as radians from 0 -> -Pi/2
@onready var pointer = $Pointer

@export var maxRotation: float = -PI/2
@export var min_scale: int = 3
@export var GM_Holder: SubViewportContainer
	
var currentRotation: float = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	GM = GM_Holder.GM
	assert(GM!=null)
	# Get the fraction of (current speed / starting speed) == (currentRotation / maxRotation)
	pointer.rotation = (1 - float(GM.current_speed)/float(GM.startingSpeed)) * maxRotation
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pointer.rotation = (1 - float(GM.current_speed)/float(GM.startingSpeed)) * maxRotation
