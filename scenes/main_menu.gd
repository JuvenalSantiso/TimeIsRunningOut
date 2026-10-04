extends Node2D

func _on_button_start_game() -> void:
	GameManager.change_scene("res://scenes/World.tscn")


func _on_start_dialogue_button_up() -> void:
	DialogueManager.start_dialogue(preload("res://dialogues/story/level_intro.tres"))
