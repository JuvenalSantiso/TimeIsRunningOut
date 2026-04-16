extends CharacterBody2D

var movement_state_machine: StateMachine

var initial_pos: Vector2 
var is_dead: bool = false


# Godot functions
func _ready():
	self.movement_state_machine = StateMachine.new(self)
	
	initial_pos = position

func _unhandled_input(event: InputEvent) -> void:
	if not is_dead:
		self.movement_state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	if not is_dead:
		self.movement_state_machine.process_physics(delta)
	
func _process(_delta: float) -> void: 
	pass
	
# Custom functions
func do_animation(color):
	$ColorRect.color = color

func convert_to_shadow():
	is_dead = true

func reset_player():
	position = initial_pos
	print("reset")

# Inputs Methods
func get_movement_input() -> float:
	return Input.get_axis('move_left', 'move_right')

func is_jumping() -> bool:
	return Input.is_action_just_pressed('jump')
