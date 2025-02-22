extends Control

@export var saveFileString: String = "user://save_game.txt"
@onready var list = $VBoxContainer/List

signal closeHighscore

func showScores():
	show()
	removeListChildren()
	loadScores()

func loadScores():
	var file = FileAccess.open("user://save_game.txt", FileAccess.READ)
	var stringFile: String
	if (FileAccess.file_exists(saveFileString)):
		file = FileAccess.open("user://save_game.txt", FileAccess.READ)
		stringFile = file.get_as_text()
		file.close()
	
	# Get the highscore list
	var highScores: Array[int]
	if (stringFile.length() > 0):
		highScores = str_to_var(stringFile)
	
	# Re-sort highscore list
	highScores.sort()
	print(highScores)
	# Generate labels and append to list

	for i in range(0,5):
		print("here")
		var item = Label.new()
		item.text = "%s) " % (i+1)
		if (i < highScores.size()):
			item.text += str(highScores[i])
		else:
			item.text += "___"

		list.add_child(item)
		

func removeListChildren():
	for child in list.get_children():
		list.remove_child(child)
		child.queue_free()


func _on_back_pressed():
	closeHighscore.emit()
