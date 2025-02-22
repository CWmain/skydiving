extends Control

@export_file("*.tscn") var sceneName

var wait: float = 1.0
var curTime: float = 0

var progress = []

@onready var cloud_explosion = $CloudExplosion
@onready var feather_explosion = $FeatherExplosion

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(sceneName != null)
	cloud_explosion.emitting = true
	feather_explosion.emitting = true
	ResourceLoader.load_threaded_request(sceneName)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ResourceLoader.load_threaded_get_status(sceneName, progress) == ResourceLoader.THREAD_LOAD_LOADED:
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(sceneName))
		
		
