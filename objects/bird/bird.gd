extends Node2D

@export var FLY_SPEED = 600;
@export var FALL_SPEED_REDUCTION = 1;

@onready var animated_bird_sprite = $AnimatedBirdSprite
@onready var feather_explosion = $FeatherExplosion

var GM: gameManager

var skydiverSpeed: int = 0

func _ready():
	animated_bird_sprite.play("default")
	GM = get_parent()
	assert(GM != null, "No parent for bird")

	if (GM.randomGen.randf() > 0.5):
		FLY_SPEED *= -1
	skydiverSpeed = GM.current_speed

func _physics_process(delta):
	position += Vector2(FLY_SPEED*delta, -GM.current_speed)
	
	# Gone off the top of the screen, so we free it
	if position.y < -50:
		queue_free()


func _on_player_detected(area):
	# Reduce the fall speed
	print("Reduce player fall speed")
	GM.current_speed -= FALL_SPEED_REDUCTION
	explodeBird()

func explodeBird():
	feather_explosion.emitting = true
	


func _on_feather_explosion_finished():
	queue_free()
