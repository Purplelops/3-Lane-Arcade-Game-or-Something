extends Node3D

var death_effect_scene: PackedScene = load("res://scenes/death_effect.tscn")
var score: int = 0
var is_player_alive: bool = true
var highscore: int = 0

var save_path: String = "user://highscore.save"

func _ready() -> void:
	randomize()
	_load_score()


func _on_player_area_entered(area: Area3D) -> void:
	if area.collision_layer == 1 and $Player.alive:
		_die()
		$RestartButton.visible = true
	
	# Collision with coin
	if area.collision_layer == 2 and $Player.alive:
		area.queue_free()
		$CoinPickupSound.play()


func _die() -> void:
	print("died")
	is_player_alive = false
	
	# Highscore
	if score > highscore:
		highscore = score
		$HighscoreScoreLabel.text = str(highscore)
		_save_score()
	
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
	
	# Hide helper UI
	if score >= 10:
		$HelpLabel.visible = false


# Score saving
func _save_score() -> void:
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(highscore)


func _load_score() -> void:
	if FileAccess.file_exists(save_path):
		print("file found")
		var file = FileAccess.open(save_path, FileAccess.READ)
		highscore = file.get_var()
		$HighscoreScoreLabel.text = str(highscore)
	else:
		print("file not found")
		highscore = 0
