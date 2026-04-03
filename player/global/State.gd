class_name State

var animation: Color  # Would be color at the moment

# Private Variables
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var player: CharacterBody2D
var _state_machine: StateMachine
var move_speed: float = 400

#Constructor
func _init(character, state_machine) -> void:
	player = character
	_state_machine = state_machine

#Generic
func enter() -> void:
	player.do_animation(animation)

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> void:
	pass

func process_frame(_delta: float) -> void:
	pass

func process_physics(_delta: float) -> void:
	pass
