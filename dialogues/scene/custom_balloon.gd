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
