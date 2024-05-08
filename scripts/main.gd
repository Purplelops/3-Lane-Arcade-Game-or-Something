extends Node3D

var death_effect_scene: PackedScene = load("res://scenes/death_effect.tscn")
var score: int = 0
var is_player_alive: bool = true

func _ready() -> void:
	randomize()


func _on_player_area_entered(area: Area3D) -> void:
	if $Player.alive:
		_die()
		$RestartButton.visible = true
	else:
		pass


func _die() -> void:
	print("died")
	is_player_alive = false
	
	# Particles
	var death_effect = death_effect_scene.instantiate()
	death_effect.position = $Player.position
	death_effect.emitting = true
	add_child(death_effect)
	
	$Player.alive = false
	$Player.visible = false
	
	$DeathSound.play()


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_score_timer_timeout() -> void:
	if $Player.alive:
		score += 1
		$ScoreLabel.text = str(score)
