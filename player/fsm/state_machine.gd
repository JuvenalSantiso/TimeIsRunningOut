class_name StateMachine

var states = {}


const IDLE_STATE = "Idle"
const MOVE_STATE = "Move"
const JUMP_STATE = "Jump"
const FALL_STATE = "Fall"

var _current_state: State

func _init(character) -> void:
	
	states[IDLE_STATE] = IdleState.new(character, self)
	states[MOVE_STATE] = MoveState.new(character, self)
	states[JUMP_STATE] = JumpState.new(character, self)
	states[FALL_STATE] = FallState.new(character, self)
	
	_current_state = states[IDLE_STATE]
	
func change_state(new_state: String) -> void:
	if _current_state:
		_current_state.exit()

	_current_state = states[new_state]
	_current_state.enter()

func process_physics(delta: float) -> void:
	_current_state.process_physics(delta)
