extends Node2D

func _on_button_start_game() -> void:
	GameManager.change_scene("res://scenes/World.tscn")
