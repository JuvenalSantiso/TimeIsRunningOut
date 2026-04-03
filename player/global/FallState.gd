extends State
class_name FallState


# Public Methods
func enter() -> void:
	animation = Color.CHARTREUSE
	super()

func process_input(_event: InputEvent) -> void:
	if player.is_on_floor() and player.get_movement_input() != 0.0:
		return _state_machine.change_state(_state_machine.MOVE_STATE)
	if player.is_on_floor():
		return _state_machine.change_state(_state_machine.IDLE_STATE)

func process_physics(delta: float) -> void:
	player.velocity.y += gravity * delta
	
	var movement = player.get_movement_input() * move_speed
	
	player.velocity.x = movement
	player.move_and_slide()
	
	if player.is_on_floor():
		if movement != 0:
			return _state_machine.change_state(_state_machine.MOVE_STATE)
		return _state_machine.change_state(_state_machine.IDLE_STATE)
