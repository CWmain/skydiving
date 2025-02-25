extends Node2D

@export var GM: gameManager
@export var FALL_SPEED_REDUCTION: int = 1

@onready var cloud_explosion = $CloudExplosion
@onready var cloud = $Cloud

@onready var cloud_puff = $CloudPuff
var canMove: bool = true
func _ready():
	GM = get_parent().GM
	assert(GM != null, "No parent for bird")
	position = Vector2(GM.randomGen.randi_range(-20,660), 400)

func _physics_process(delta):
	if !canMove:
		return
	position += Vector2(0, -GM.current_speed*delta)
	
	# Gone off the top of the screen, so we free it
	if position.y < -50 or position.x < -50 or position.x > 700:
		get_parent().spawnCount -= 1
		queue_free()

func _on_player_detected(area):
	# This prevents double detects
	if !canMove:
		return
	# Reduce the fall speed
	canMove = false
	GM.current_speed -= FALL_SPEED_REDUCTION
	explodeCloud()

func explodeCloud():
	cloud.hide()
	cloud_puff.play()
	cloud_explosion.emitting = true


func _on_cloud_explosion_finished():
	get_parent().spawnCount -= 1
	queue_free()
