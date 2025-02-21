extends Control

@onready var settings = $Settings
@onready var menu_items = $MenuItems

func reveal():
	show()
	get_tree().paused = true

func _on_retry_pressed():
	get_tree().paused = false
	print("Button pressed")
	get_tree().reload_current_scene()


func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Levels/main_menu.tscn")


func _on_resume_pressed():
	get_tree().paused = false
	hide()
	print("resume")


func _on_settings_pressed():
	settings.show()
	menu_items.hide()


func _on_settings_closed_settings():
	menu_items.show()
	settings.hide()
