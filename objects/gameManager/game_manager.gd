extends Node

class_name gameManager

## Speed in meters per second
@export var startingSpeed: int = 100
## Height in meters
@export var startingHeight: int = 3000

## The smallest the skydivers speed can be reduced to
@export var minSpeed: int = 0

@export var groundHeight: int = 32

# Stops other objects from moving up and makes the skydiver move down
var lockScreen: bool = false
var randomGen: RandomNumberGenerator = RandomNumberGenerator.new()

# Spawnable objects
const BIRD = preload("res://objects/bird/bird.tscn")

var current_speed: float = 0:
	set(value):
		current_speed = clamp(value,minSpeed, startingSpeed) if !lockScreen else max(value,0)

var current_height: float = 0
var spawnedGround: bool = false
var oldHeight: float = 0
var spawnTimer: float = 0
var addSpeedTimer: float = 0

var lastSpeed: int = 0

signal spawn
signal spawnGround
signal landOnGround
signal reset
signal introAnimation
signal endScreen
# The below are the percentage values for each damage zone
# Splatter		Red >= -17.5			20%
# Injured		Yellow >= -72.4			80%
# Safe			Green >= -90			20%

var percentSplatter: float = 0.8
var percentInjured: float = 0.2
var percentSafe: float = 0.0

## Indicates if the user has started the game
var inGame: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	current_speed = startingSpeed
	current_height = startingHeight
	oldHeight = startingHeight


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !inGame:
		return
	if !spawnedGround and current_height <= 360:
		spawnGround.emit()
	
	if !lockScreen and current_height <= 360-groundHeight:
		lockScreen = true
		lastSpeed = current_speed
		current_speed = 0
		landOnGround.emit()

	#Calculate height difference
	var heightDiff = oldHeight - current_height

	oldHeight = current_height
	spawnTimer += heightDiff

	
	# Timers
	addSpeedTimer += delta
	
	# Spawn random every set seconds
	if !lockScreen and spawnTimer >= 48.0:
		spawnRandom()
		spawnTimer -= 48.0
	
	# Increase speed every set seconds	
	if !lockScreen and addSpeedTimer >= 0.5:
		current_speed += 2
		addSpeedTimer -= 0.5
		
	current_height -= current_speed*delta

	if Input.is_action_just_pressed("spawnRandom"):
		spawnRandom()
	if Input.is_action_just_pressed("NearGroundDebug"):
		current_height = 1000
		oldHeight = 1000
		current_speed = 200
# Reset all key varaibles and inform spawner to clear all children, inform skydiver to reset to default
func restartGame():
	inGame = true
	current_height = startingHeight
	oldHeight = current_height
	current_speed = startingSpeed
	spawnTimer = 0
	addSpeedTimer = 0
	
	lockScreen = false
	spawnedGround = false
	
	reset.emit()
	

func spawnRandom():
	spawn.emit()
	
	
