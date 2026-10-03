extends Node
class_name DialogueManager

var current_dialogue: DialogueResource
var current_line_index: int = 0


func start_dialogue(dialogue: DialogueResource):
	current_dialogue = dialogue
	current_line_index = 0

	show_current_line()


func show_current_line():
	if current_dialogue == null:
		return

	if current_line_index >= current_dialogue.lines.size():
		end_dialogue()
		return

	var line := current_dialogue.lines[current_line_index]

	print(line.speaker.display_name)
	print(line.emotion)
	print(line.text)

func next_line():
	current_line_index += 1
	show_current_line()


func end_dialogue():
	current_dialogue = null
	current_line_index = 0

	print("Dialogue finished.")
