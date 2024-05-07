extends Node3D

var death_effect_scene: PackedScene = load("res://death_effect.tscn")

func _ready() -> void:
	randomize()


func _on_player_area_entered(area: Area3D) -> void:
	if $Player.alive:
		_die()
	else:
		pass


func _die() -> void:
	print("died")
	
	# Particles
	var death_effect = death_effect_scene.instantiate()
	death_effect.position = $Player.position
	death_effect.emitting = true
	add_child(death_effect)
	
	$Player.alive = false
	$Player.visible = false
