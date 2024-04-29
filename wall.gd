extends Area3D

var speed

func _process(delta: float) -> void:
	position.z += speed * delta
