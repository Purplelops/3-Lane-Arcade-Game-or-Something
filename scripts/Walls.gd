extends Node3D

var wall_scene: PackedScene = load("res://scenes/wall.tscn")
var coin_scene: PackedScene = load("res://scenes/coin.tscn")

var wall_positions: Array = [-3, 0, 3]
var wall_speed: int = 10
var skip_next_walls: bool = false
var max_wall_speed: int = 40


func _spawn_walls(spd):
	var no_wall: int = randi_range(0, 2)
	
	if skip_next_walls:
		skip_next_walls = false
	else:
		for i in range(3):
			if no_wall == i:
				if randi_range(0, 2) == 1:
					var coin = coin_scene.instantiate()
					coin.position = Vector3(wall_positions[i], 1, -22)
					coin.speed = spd
					add_child(coin)
			else:
				var wall = wall_scene.instantiate()
				wall.position = Vector3(wall_positions[i], 1, -22)
				wall.speed = spd
				add_child(wall)


func _on_wall_spawn_timer_timeout() -> void:
	if $"..".is_player_alive:
		_spawn_walls(wall_speed)


func _on_speed_up_timer_timeout() -> void:
	print(wall_speed)
	if wall_speed < max_wall_speed:
		skip_next_walls = true
		wall_speed += 3
		$WallSpawnTimer.wait_time *= 0.9
