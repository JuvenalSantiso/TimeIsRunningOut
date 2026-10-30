@tool
extends EditorPlugin

var dock: Control


func _enter_tree():
	var scene := preload("res://addons/dialogue_tools/dialogue_dock.tscn")
	dock = scene.instantiate()

	add_control_to_dock(DOCK_SLOT_RIGHT_UL, dock)


func _exit_tree():
	remove_control_from_docks(dock)
	dock.queue_free()
