class_name BufferMirrorEvents

var _mirror_action_buffer: Array[FrameInput] = []
var _action_buffer: Array[FrameInput] = []

var _current_action: FrameInput

func set_mirror_events():
	_action_buffer = _mirror_action_buffer
	pop_buffer_action()

func capture_input(input_event: FrameInput):
	_mirror_action_buffer.append(input_event)
	
func pop_buffer_action():
	self._current_action = _action_buffer.pop_front()
	if _current_action == null:
		_action_buffer = _mirror_action_buffer

func get_current_action() -> FrameInput:
	return _current_action
