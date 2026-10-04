extends Node

signal dialogue_started
signal dialogue_finished
signal line_changed(line: DialogueLine)

var current_dialogue: DialogueResource
var current_line_index: int = 0


func start_dialogue(dialogue: DialogueResource):
	current_dialogue = dialogue
	current_line_index = 0

	dialogue_started.emit()

	show_current_line()


func show_current_line():
	if current_dialogue == null:
		return

	if current_line_index >= current_dialogue.lines.size():
		end_dialogue()
		return

	var line := current_dialogue.lines[current_line_index]
	line_changed.emit(line)

func next_line():
	current_line_index += 1
	show_current_line()


func end_dialogue():
	current_dialogue = null
	current_line_index = 0
	
	dialogue_finished.emit()

	print("Dialogue finished.")
