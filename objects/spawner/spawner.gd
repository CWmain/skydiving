extends Node

@export var spawnLimit: int = 10
@export var birdSpawns: Array[SpawnPattern]

var curSpawnPattern: SpawnPattern = null
var curSpawnPatternIndex: int = 0

const BIRD = preload("res://objects/bird/bird.tscn")
const CLOUD = preload("res://objects/cloud/cloud.tscn")
const GROUND = preload("res://objects/ground/ground.tscn")

var spawnCount: int = 0
var GM: gameManager

var oldDist: float = 0
var birdSpawnTimer: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GM = get_parent().get_parent().GM
	assert(GM != null)
	GM.spawn.connect(spawnBird)
	GM.spawnGround.connect(spawnGround)
	GM.reset.connect(restartGame)
	oldDist = GM.startingHeight


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	# Stop spawning birds when below 400
	if GM.current_height < 400:
		return
	
	var heightDiff = oldDist - GM.current_height
	oldDist = GM.current_height
	birdSpawnTimer += heightDiff
	
	# Ensures a pattern exists
	if curSpawnPattern == null or curSpawnPattern.spawnLocations.size() == curSpawnPatternIndex:
		# Multiple float by birdSpawns.size() to get the selection index
		var selection = int(GM.randomGen.randf() * birdSpawns.size()) % (birdSpawns.size())

		curSpawnPattern = birdSpawns[selection]
		curSpawnPatternIndex = 0

	if birdSpawnTimer >= curSpawnPattern.spawnDistance:

		birdSpawnTimer -= curSpawnPattern.spawnDistance
		if curSpawnPattern.toSpawn == "BIRD":
			for newXY in curSpawnPattern.spawnLocations[curSpawnPatternIndex].list:
				var newBird = BIRD.instantiate()
				newBird.position = newXY
				add_child(newBird)
		curSpawnPatternIndex += 1
			
		

func spawnBird():
	# Limit spawns to spawnLimit
	#if spawnCount > spawnLimit:
	#	return
	var toSpawn: float = GM.randomGen.randf()
	if toSpawn > 1:
		var newBird = BIRD.instantiate()
		newBird.position = Vector2(GM.randomGen.randf()*640, 370)
		add_child(newBird)
	elif GM.current_height > 500:	
		var newCloud = CLOUD.instantiate()
		add_child(newCloud)
	spawnCount += 1

func spawnGround():
	var newGround = GROUND.instantiate()
	add_child(newGround)
	
func restartGame():
	oldDist = GM.startingHeight
	# Free all children
	for child in get_children():
		child.queue_free()
