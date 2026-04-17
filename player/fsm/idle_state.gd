extends State
class_name IdleState


# Public Methods
func enter() -> void:
	animation = Color.REBECCA_PURPLE
	super()
	player.velocity.x = 0

func process_physics(delta: float) -> void:
	player.velocity.y += gravity * delta
	player.move_and_slide()
	
	if player.is_jumping() and player.is_on_floor():
		return _state_machine.change_state(_state_machine.JUMP_STATE)
	if player.get_movement_input() != 0.0:
		return _state_machine.change_state(_state_machine.MOVE_STATE)
