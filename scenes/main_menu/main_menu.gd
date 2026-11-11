extends Node2D

func _on_button_start_game() -> void:
	GameManager.change_scene("res://scenes/levels/World.tscn")


func _on_start_dialogue_button_up() -> void:
	DialogueManager.start_dialogue(preload("res://data/dialogues/story/level_00.tres"))
