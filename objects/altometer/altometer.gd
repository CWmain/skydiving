extends Control

@onready var alt_arrow = $AltArrow

@export var top: float = -25
@export var bottom: float = 25
@export var GM_Holder: SubViewportContainer
var height: float = bottom - top

var GM: gameManager
# Called when the node enters the scene tree for the first time.
func _ready():
	GM = GM_Holder.GM
	assert(GM!=null)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	alt_arrow.position.y = top + (1 - float(GM.current_height)/float(GM.startingHeight)) * height
