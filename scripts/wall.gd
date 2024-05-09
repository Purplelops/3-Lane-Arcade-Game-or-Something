extends Area3D

var speed = 1

func _process(delta: float) -> void:
	position.z += speed * delta


func _on_self_destruct_timer_timeout() -> void:
	queue_free()
