extends Node

class_name gameManager

## Speed in meters per second
@export var startingSpeed: int = 100
## Height in meters
@export var startingHeight: int = 3000

## The smallest the skydivers speed can be reduced to
@export var minSpeed: int = 0

@export var groundHeight: int = 32

var endGame: bool = false
var randomGen: RandomNumberGenerator = RandomNumberGenerator.new()

# Spawnable objects
const BIRD = preload("res://objects/bird/bird.tscn")

var current_speed = 0:
	set(value):
		current_speed = clamp(value,minSpeed, startingSpeed) if !endGame else max(value,0)

var current_height = 0;

var spawnTimer: float = 0
var addSpeedTimer: float = 0

signal spawn

# Called when the node enters the scene tree for the first time.
func _ready():
	current_speed = startingSpeed
	current_height = startingHeight

signal landOnGround

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !endGame and current_height <= 360-groundHeight:
		endGame = true
		landOnGround.emit()

	# Timers
	spawnTimer += delta
	addSpeedTimer += delta
	
	if !endGame and spawnTimer > 0.05:
		spawnRandom()
		spawnTimer = 0
		
	if !endGame and addSpeedTimer > 0.5:
		current_speed += 1
		addSpeedTimer = 0
		
	current_height -= current_speed*delta

	if Input.is_action_just_pressed("spawnRandom"):
		spawnRandom()
	if Input.is_action_just_pressed("NearGroundDebug"):
		current_height = 1000
		#current_speed = 100
	
func spawnRandom():
	spawn.emit()
	
	
