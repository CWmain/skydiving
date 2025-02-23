extends Node2D

@export var FLY_SPEED = 300;
@export var FALL_SPEED_REDUCTION = 10;

@onready var animated_bird_sprite = $AnimatedBirdSprite
@onready var feather_explosion = $FeatherExplosion
@onready var player_detectable = $PlayerDetectable

var GM: gameManager

var skydiverSpeed: int = 0
@onready var bird_sqwuak = $BirdSqwuak

var canMove: bool = true

func _ready():
	GM = get_parent().GM
	assert(GM != null, "No parent for bird")
	
	animated_bird_sprite.play("default")
	if (position.x > 320):
		FLY_SPEED *= -1
		animated_bird_sprite.flip_h = true

	skydiverSpeed = GM.current_speed

func _physics_process(delta):
	if !canMove:
		return
	position += Vector2(FLY_SPEED*delta, -GM.current_speed*delta)
	
	# Gone off the top of the screen, so we free it
	if position.y < -50 or position.x < -50 or position.x > 700:
		get_parent().spawnCount -= 1
		queue_free()


func _on_player_detected(area):
	# This prevents double detects
	if !canMove:
		return
	# Reduce the fall speed
	GM.current_speed -= FALL_SPEED_REDUCTION
	canMove = false
	explodeBird()

func explodeBird():
	animated_bird_sprite.hide()
	bird_sqwuak.play()
	feather_explosion.emitting = true


func _on_feather_explosion_finished():
	print("particles done")
	#queue_free()


func _on_bird_sqwuak_finished():
	get_parent().spawnCount -= 1
	queue_free()
