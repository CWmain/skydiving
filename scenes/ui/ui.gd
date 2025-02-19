extends SubViewportContainer

@export var GM: gameManager

@onready var sub_viewport = $SubViewport
@export var min_scale: int = 3

const baseSize: Vector2 = Vector2(640, 360)

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(GM != null, "GM not assigned to UI viewport")
	get_tree().get_root().size_changed.connect(_on_resize)
	_on_resize()

func _on_resize():
	var windowSize: Vector2 = DisplayServer.window_get_size()
	var worldSize = Vector2(sub_viewport.size)
	# Decrease world size, when larger than screen size
	if (worldSize > windowSize):
		sub_viewport.size.x = max(baseSize.x, sub_viewport.size.x - baseSize.x)
		sub_viewport.size.y = max(baseSize.y, sub_viewport.size.y - baseSize.y)
		# Decrease scale of all childern
		for child in sub_viewport.get_children():
			child.scale.x = max(min_scale, child.scale.x-1)
			child.scale.y = max(min_scale, child.scale.y-1)
		
		
	# Increase world size if an integer increase fits the current screen size
	if (worldSize + baseSize <= windowSize):
		sub_viewport.size += Vector2i(baseSize)
		# Increase scale of all children
		for child in sub_viewport.get_children():
			child.scale += Vector2(1,1)
	print(sub_viewport.size)
