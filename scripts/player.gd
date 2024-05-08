extends Area3D

var move_step: int = 3
var lerp_speed: float = 4.0
var alive: bool = true

func _process(delta: float) -> void:
	if alive:
		if Input.is_action_just_pressed("left") and position.x > -2:
			position.x -= move_step
		elif Input.is_action_just_pressed("right") and position.x < 2:
			position.x += move_step
