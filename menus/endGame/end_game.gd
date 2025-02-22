extends Control

@export var GM_HOLDER: SubViewportContainer
var GM: gameManager

@onready var v_box_container = $VBoxContainer
@onready var score = $VBoxContainer/Score
@onready var settings = $Settings

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(GM_HOLDER != null)
	GM = GM_HOLDER.GM
	GM.endScreen.connect(_showEndScreen)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_retry_pressed():
	hide()
	GM.restartGame()


func _on_main_menu_pressed():
	get_tree().reload_current_scene()

func _showEndScreen():
	show()
	GM.inGame = false
	score.text = str(GM.lastSpeed)


func _on_settings_closed_settings():
	settings.hide()
	v_box_container.show()


func _on_settings_pressed():
	v_box_container.hide()
	settings.show()
