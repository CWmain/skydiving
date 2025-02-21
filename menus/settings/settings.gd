extends Control

@onready var master_slider = $VBoxContainer/MasterSlider
@onready var music_slider = $VBoxContainer/MusicSlider
@onready var sfx_slider = $VBoxContainer/SFXSlider

signal closedSettings

# Called when the node enters the scene tree for the first time.
func _ready():
	master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(2))

func _on_back_pressed():
	closedSettings.emit()


func _on_confirm_pressed():
	AudioServer.set_bus_volume_db(0, linear_to_db(master_slider.value))
	AudioServer.set_bus_volume_db(1, linear_to_db(music_slider.value))
	AudioServer.set_bus_volume_db(2, linear_to_db(sfx_slider.value))
