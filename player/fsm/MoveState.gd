extends State
class_name MoveState

# Public Methods
func enter() -> void:
	animation = Color.DARK_GOLDENROD
	super()
	player.velocity.x = 0

func process_physics(delta: float) -> void:
	if player.is_jumping() and player.is_on_floor():
		return _state_machine.change_state(_state_machine.JUMP_STATE)

	player.velocity.y += gravity * delta

	var movement = player.get_movement_input() * move_speed
	
	if movement == 0:
		return _state_machine.change_state(_state_machine.IDLE_STATE)
	
	player.velocity.x = movement
	player.move_and_slide()
	
