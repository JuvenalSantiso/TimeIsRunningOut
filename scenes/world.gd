extends Node2D

func _ready():
	GameManager.init_game_manager($Spawn)
	$NextGeneration.start()



func _on_next_generation_timeout() -> void:
	GameManager.next_generation()
