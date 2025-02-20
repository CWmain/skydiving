extends Node

@export var spawnLimit: int = 10

const BIRD = preload("res://objects/bird/bird.tscn")
const CLOUD = preload("res://objects/cloud/cloud.tscn")
const GROUND = preload("res://objects/ground/ground.tscn")

var spawnCount: int = 0
var GM: gameManager

# Called when the node enters the scene tree for the first time.
func _ready():
	GM = get_parent().get_parent().GM
	assert(GM != null)
	GM.spawn.connect(spawnBird)
	GM.spawnGround.connect(spawnGround)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawnBird():
	# Limit spawns to spawnLimit
	if spawnCount > spawnLimit:
		return
	var toSpawn: float = GM.randomGen.randf()
	if toSpawn > 0.5:
		var newBird = BIRD.instantiate()
		add_child(newBird)
	elif GM.current_height > 500:	
		var newCloud = CLOUD.instantiate()
		add_child(newCloud)
	spawnCount += 1

func spawnGround():
	var newGround = GROUND.instantiate()
	add_child(newGround)
