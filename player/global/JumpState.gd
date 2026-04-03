extends State
class_name JumpState

var jump_force: float = 400.0

# Public Methods
func enter() -> void:
	animation = Color.BLUE
	super()
	player.velocity.y = -jump_force

func process_physics(delta: float) -> void:
	
	player.velocity.y += gravity * delta
	
	if player.velocity.y > 0:
		return _state_machine.change_state(_state_machine.FALL_STATE)
	
	var movement = player.get_movement_input() * move_speed
	
	player.velocity.x = movement
	player.move_and_slide()
	
	if player.is_on_floor():
		if movement != 0:
			return _state_machine.change_state(_state_machine.MOVE_STATE)
		return _state_machine.change_state(_state_machine.IDLE_STATE)
