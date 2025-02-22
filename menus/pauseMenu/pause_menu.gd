extends Control

@onready var settings_menu = $SettingsMenu
@onready var v_box_container = $VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_resume_pressed():
	print("resume")
	get_tree().paused = false
	hide()


func _on_retry_pressed():
	print("resume")
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_settings_pressed():
	v_box_container.hide()
	settings_menu.refreshSliderValues()
	settings_menu.show()
	



func _on_main_menu_pressed():
	print("Go to main menu")


func _on_settings_menu_closed_settings():
	settings_menu.hide()
	v_box_container.show()
