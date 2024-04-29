extends Node3D

var wall_scene: PackedScene = load("res://wall.tscn")
var wall_positions = [-3, 0, 3]

# REDO THIS. Find a way to spawn two walls that are not inside of each other.
func _spawn_wall(pos, spd):
	var wall = wall_scene.instantiate()
	wall.position = Vector3(pos, 1, -22)
	wall.speed = spd
	add_child(wall)


func _on_wall_spawn_timer_timeout() -> void:
	_spawn_wall(wall_positions.pick_random(), 10)
