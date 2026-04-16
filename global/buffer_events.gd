class_name BufferEvents

var _mirror_action_buffer: Array[InputEvent] = []
var _action_buffer: Array[InputEvent] = []

func set_mirror_events():
	_action_buffer = _mirror_action_buffer

func capture_input(input_event: InputEvent):
	_mirror_action_buffer.append(input_event)
	
func pop_buffer_action() -> InputEvent:
	var current_action = _action_buffer.pop_front()
	if current_action == null:
		_action_buffer = _mirror_action_buffer
	return current_action
