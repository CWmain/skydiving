extends Node

class_name gameManager

## Speed in meters per second
@export var startingSpeed: int = 100
## Height in meters
@export var startingHeight: int = 3000

## The smallest the skydivers speed can be reduced to
@export var minSpeed: int = 1

var randomGen: RandomNumberGenerator = RandomNumberGenerator.new()

# Spawnable objects
const BIRD = preload("res://objects/bird/bird.tscn")
var current_speed = 0:
	set(value):
		current_speed = max(value,minSpeed)

var current_height = 0;


# Called when the node enters the scene tree for the first time.
func _ready():
	current_speed = startingSpeed
	current_height = startingHeight


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	current_height -= current_speed*delta
	#print(current_height)
	if Input.is_action_just_pressed("spawnRandom"):
		spawnRandom()
		
	
func spawnRandom():
	print("spawning bird")
	var newBird = BIRD.instantiate()
	add_child(newBird)
	newBird.position = Vector2(randomGen.randi_range(-20,660), 400)
