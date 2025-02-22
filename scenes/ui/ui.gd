extends SubViewportContainer

@export var GM: gameManager

@onready var sub_viewport = $SubViewport
@export var base_scale: int = 3

@onready var game_info = $SubViewport/gameInfo

@onready var pause_screen = $SubViewport/PauseMenu
@onready var main_menu = $SubViewport/MainMenu
@onready var end_game = $SubViewport/EndGame


const baseSize: Vector2 = Vector2(640, 360)


# Called when the node enters the scene tree for the first time.
func _ready():
	assert(GM != null, "GM not assigned to UI viewport")
	get_tree().get_root().size_changed.connect(_on_resize)
	_on_resize()
	

func _process(_delta):
	if GM.inGame:
		game_info.show()
	if Input.is_action_just_pressed("pause") and GM.inGame:
		pause_screen.show()
		get_tree().paused = true

func _on_resize():
	var windowSize: Vector2 = DisplayServer.window_get_size()
	var worldSize = Vector2(sub_viewport.size)
	# Decrease world size, when larger than screen size
	if (worldSize > windowSize):
		sub_viewport.size.x = max(baseSize.x, sub_viewport.size.x - baseSize.x)
		sub_viewport.size.y = max(baseSize.y, sub_viewport.size.y - baseSize.y)
		# Decrease scale of all childern
		game_info.scale.x = max(base_scale, game_info.scale.x-1)
		game_info.scale.y = max(base_scale, game_info.scale.y-1)
		
		pause_screen.scale.x = max(1, pause_screen.scale.x-1)
		pause_screen.scale.y = max(1, pause_screen.scale.y-1)
		
		main_menu.scale.x = max(1, main_menu.scale.x-1)
		main_menu.scale.y = max(1, main_menu.scale.y-1)
		
		end_game.scale.x = max(1, end_game.scale.x-1)
		end_game.scale.y = max(1, end_game.scale.y-1)
		
		
	# Increase world size if an integer increase fits the current screen size
	if (worldSize + baseSize <= windowSize):
		sub_viewport.size += Vector2i(baseSize)
		# Increase scale of all children
		for child in sub_viewport.get_children():
			child.scale += Vector2(1,1)
	print(sub_viewport.size)


func _on_button_pressed():
	print("This bytton works")


func _on_main_menu_start_game():
	GM.introAnimation.emit()
	main_menu.hide()
	
