extends CharacterBody2D

var movement_state_machine: StateMachine
var buffer_mirror: BufferMirrorEvents

var initial_pos: Vector2 
var is_dead: bool = false

func _enter_tree() -> void:
	self.buffer_mirror = BufferMirrorEvents.new()
	
# Godot functions
func _ready():
	self.movement_state_machine = StateMachine.new(self)
	self.initial_pos = position

func _physics_process(delta: float) -> void:
	self.movement_state_machine.process_physics(delta)
	
	if not is_dead:
		var new_input_frame = FrameInput.new()
		new_input_frame.movement = self.get_movement_input()
		new_input_frame.jump = self.is_jumping()
		self.buffer_mirror.capture_input(new_input_frame)
	else:
		self.buffer_mirror.pop_buffer_action()
	
func _process(_delta: float) -> void: 
	pass
	
# Custom functions
func do_animation(color):
	$ColorRect.color = color
	
func reset_player():
	print("reset")
	position = self.initial_pos
	
	self.is_dead = true
	self.buffer_mirror.set_mirror_events()

# Inputs Methods
func get_movement_input() -> float:
	if not is_dead:
		return Input.get_axis('move_left', 'move_right')
	return self.buffer_mirror.get_current_action().get_movement_input()

func is_jumping() -> bool:
	if not is_dead:
		return Input.is_action_just_pressed('jump')
	return self.buffer_mirror.get_current_action().is_jumping()
