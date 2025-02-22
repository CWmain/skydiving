extends Control

signal startGame

@onready var v_box_container = $VBoxContainer
@onready var settings = $Settings
@onready var high_scores = $HighScores



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_play_pressed():
	startGame.emit()

func _on_settings_pressed():
	v_box_container.hide()
	settings.show()

func _on_settings_closed_settings():
	settings.hide()
	v_box_container.show()


func _on_high_scores_pressed():
	v_box_container.hide()
	high_scores.showScores()


func _on_high_scores_close_highscore():
	high_scores.hide()
	v_box_container.show()
