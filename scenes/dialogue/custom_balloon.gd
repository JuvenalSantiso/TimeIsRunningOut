extends CanvasLayer

@export var start_from_title: String = ""

## If all other input is blocked as long as dialogue is shown.
@export var will_block_other_input: bool = true

@export var next_action: StringName = "ui_accept"
@export var skip_action: StringName = "ui_cancel"

## A sound player for voice lines (if they exist).
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer

## See if we are waiting for the player
var is_waiting_for_input: bool = false

func _ready():
	DialogueManager.line_changed.connect(_on_line_changed)
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_finished.connect(_on_dialogue_finished)
	

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("ui_left")): #TODO: Cambiar y revisa esta action
		DialogueManager.next_line()

func _on_line_changed(line: DialogueLine):
	# Actualizar nombre
	%Character_name.text = line.speaker.display_name
	# Actualizar texto
	%DialogText.text = line.text
	# Actualizar retrato
	# Reproducir sonido


func _on_dialogue_started():
	visible = true


func _on_dialogue_finished():
	visible = false
