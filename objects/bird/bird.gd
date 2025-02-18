extends Node2D

@export var SPEED = 100;
@onready var animated_bird_sprite = $AnimatedBirdSprite

func _ready():
	animated_bird_sprite.play("default")

func _physics_process(delta):
	position += Vector2(SPEED*delta, 0)
