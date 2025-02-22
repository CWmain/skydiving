extends Control

@export var GM_HOLDER: SubViewportContainer
var GM: gameManager

@onready var settings = $Settings

@onready var v_box_container = $VBoxContainer
@onready var status = $VBoxContainer/Status
@onready var score = $VBoxContainer/Score

@onready var high_scores = $HighScores

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(GM_HOLDER != null)
	GM = GM_HOLDER.GM
	GM.endScreen.connect(_startEndScreenTimer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_retry_pressed():
	hide()
	GM.restartGame()

func _on_main_menu_pressed():
	get_tree().reload_current_scene()

func _startEndScreenTimer():
	timer.start()

func _on_timer_timeout():
	_showEndScreen()

func _showEndScreen():
	show()
	GM.inGame = false
	var percentSpeed = (float(GM.lastSpeed-GM.minSpeed)/float(GM.startingSpeed-GM.minSpeed))
	if (percentSpeed > GM.percentSplatter):
		status.text = "You Died"

	elif (percentSpeed > GM.percentInjured):
		status.text = "You were Injured"

	else:
		status.text = "You survived!"
	score.text = str(GM.lastSpeed)

func _on_settings_closed_settings():
	settings.hide()
	v_box_container.show()


func _on_settings_pressed():
	v_box_container.hide()
	settings.show()

func _on_high_scores_close_highscore():
	high_scores.hide()
	v_box_container.show()

func _on_highscores_pressed():
	v_box_container.hide()
	high_scores.showScores()
