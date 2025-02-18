extends Node

const BASE_WORLD_SIZE: Vector2 = Vector2(640,360)

@onready var world = $World

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().size_changed.connect(_on_resize)
	
	# Trigger the scaling of world
	_on_resize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_resize():
	var windowSize: Vector2 = DisplayServer.window_get_size()
	# Scale the world size to its 'real' size
	var worldSize: Vector2 = world.size * world.scale
	
	# Decrease world size, when larger than screen size
	if (worldSize > windowSize):
		world.scale.x = max(1, world.scale.x - 1)
		world.scale.y = max(1, world.scale.y - 1)
		
	# Increase world size if an integer increase fits the current screen size
	if (worldSize + world.size <= windowSize):
		world.scale = world.scale + Vector2(1,1)
	
