extends Node

var spawn_players : Node2D
var player_scene: PackedScene = preload("res://player/player.tscn")

var add_new_player: bool = false
var restart_level: bool = false

#region level control
func init_game_manager(marker_spawn):
	spawn_players = marker_spawn
	spawn_player()

func restart_level_manager():
	add_new_player = false
	call_deferred("delete_players")

func next_generation():
	add_new_player = true
	print("next")

func spawn_player():
	var player = player_scene.instantiate()
	spawn_players.add_child(player)

func spawn_new_player():
	var player = player_scene.instantiate()
	player.convert_to_shadow()
	spawn_players.add_child(player)

func delete_players():
	for pl in get_tree().get_nodes_in_group("players"):
			pl.queue_free()

func _physics_process(_delta):
	if add_new_player:
		add_new_player = false
		for pl in get_tree().get_nodes_in_group("players"):
			pl.reset_player()
		spawn_new_player()

#endregion

#region Transitions scenes
func change_scene(new_scene : String):
	call_deferred("defered_change_scene", new_scene)

func defered_change_scene(new_scene : String):
	get_tree().change_scene_to_file(new_scene)
#endregion
