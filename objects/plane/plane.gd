extends Node2D

@onready var plane_door = $PlaneDoor

## True means show door, otherwise hide it
@export var doorState: bool = true:
	set(value):
		if (plane_door == null):
			doorState = value
			return		
		if (value):
			plane_door.show()
		else:
			plane_door.hide()
		doorState = value
		
func _ready():
	if (doorState):
		plane_door.show()
	else:
		plane_door.hide()
