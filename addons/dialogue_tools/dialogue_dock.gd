@tool
extends VBoxContainer

@export var character_database: CharacterDatabase

@onready var import_button: Button = $ImportButton
@onready var status_label: Label = $StatusTag
@onready var file_dialog: FileDialog = $FileDialog


func _ready() -> void:
	import_button.pressed.connect(_on_import_pressed)
	file_dialog.file_selected.connect(_on_file_selected)

	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.access = FileDialog.ACCESS_RESOURCES
	file_dialog.add_filter("*.csv", "CSV Files")


func _on_import_pressed() -> void:
	file_dialog.popup_centered_ratio(0.7)


func _on_file_selected(path: String) -> void:
	import_csv(path)


func import_csv(path: String) -> void:
	if character_database == null:
		show_error("Assign a CharacterDatabase first.")
		return

	var file = FileAccess.open(path, FileAccess.READ)

	if file == null:
		show_error("Could not open: " + path)
		return

	var headers = file.get_csv_line()

	if headers.size() != 3:
		file.close()
		show_error("Expected: character,emotion,text")
		return

	headers[0] = headers[0].trim_prefix("\uFEFF")

	for i in range(headers.size()):
		headers[i] = headers[i].strip_edges().to_lower()

	if headers != PackedStringArray([
		"character", "emotion", "text"
	]):
		file.close()
		show_error("Invalid CSV headers.")
		return

	var dialogue = DialogueResource.new()
	var row_number = 1

	while not file.eof_reached():
		var row = file.get_csv_line()
		row_number += 1

		if row.size() == 1 and row[0].strip_edges().is_empty():
			continue

		if row.size() != 3:
			file.close()
			show_error("Invalid CSV row: %d" % row_number)
			return

		var character_id = row[0].strip_edges()
		var emotion_name = row[1].strip_edges().to_upper()
		var dialogue_text = row[2]

		var character = character_database.get_character(StringName(character_id))

		if character == null:
			file.close()
			show_error(
                "Unknown character '%s' at row %d"
				% [character_id, row_number]
			)
			return

		var emotion_value: int = Emotion.Type.get(
			emotion_name, -1
		)

		if emotion_value == -1:
			file.close()
			show_error(
                "Unknown emotion '%s' at row %d"
				% [emotion_name, row_number]
			)
			return

		var line = DialogueLine.new()
		line.speaker = character
		line.emotion = emotion_value
		line.text = dialogue_text

		dialogue.lines.append(line)

	file.close()

	if dialogue.lines.is_empty():
		show_error("CSV contains no dialogue lines.")
		return

	var output_path = path.get_basename() + ".tres"

	var error = ResourceSaver.save(dialogue, output_path)

	if error != OK:
		show_error("Failed to save dialogue: %s" % error_string(error))
		return

	EditorInterface.get_resource_filesystem().scan()

	status_label.text = "Imported %d lines!" % dialogue.lines.size()

	print("Dialogue saved to: ", output_path)


func show_error(message: String) -> void:
	status_label.text = "ERROR: " + message
	push_error(message)
