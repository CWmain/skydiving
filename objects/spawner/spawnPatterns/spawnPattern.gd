extends Resource

class_name SpawnPattern

## The scene object to spawn
@export var toSpawn: String

## The distance between spawning groups
@export var spawnDistance: int

## The list of spawn locations
@export var spawnLocations: Array[SpawnPoints]
