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

var current_speed = 0:
	set(value):
		current_speed = clamp(value,minSpeed, startingSpeed) if !lockScreen else max(value,0)

var current_height: float = 0;
var spawnedGround: bool = false
var spawnTimer: float = 0
var addSpeedTimer: float = 0

var lastSpeed: int = 0

signal spawn
signal spawnGround
signal landOnGround

# The below are the percentage values for each damage zone
# Splatter		Red >= -17.5			20%
# Injured		Yellow >= -72.4			80%
# Safe			Green >= -90			20%


# Called when the node enters the scene tree for the first time.
func _ready():
	current_speed = startingSpeed
	current_height = startingHeight


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !spawnedGround and current_height <= 360:
		spawnGround.emit()
	
	if !lockScreen and current_height <= 360-groundHeight:
		lockScreen = true
		lastSpeed = current_speed
		current_speed = 0
		landOnGround.emit()

	# Timers
	spawnTimer += delta
	addSpeedTimer += delta
	
	if !lockScreen and spawnTimer > 0.05:
		spawnRandom()
		spawnTimer = 0
		
	if !lockScreen and addSpeedTimer > 0.5:
		current_speed += 1
		addSpeedTimer = 0
		
	current_height -= current_speed*delta

	if Input.is_action_just_pressed("spawnRandom"):
		spawnRandom()
	if Input.is_action_just_pressed("NearGroundDebug"):
		current_height = 1000
		current_speed = 350
	
func spawnRandom():
	spawn.emit()
	
	
