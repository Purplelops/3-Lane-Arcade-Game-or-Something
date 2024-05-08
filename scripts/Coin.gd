# This entire class could inherit from the wall class, but I am lazy

extends Area3D

var y_pos = 0
var float_speed = 4
var speed = 1

func _physics_process(delta: float) -> void:
	position.z += speed * delta


func _on_self_destruct_timer_timeout() -> void:
	queue_free()
