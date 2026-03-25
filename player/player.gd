extends CharacterBody2D

var movement_state_machine: StateMachine

# Godot functions
func _ready():
	self.movement_state_machine = StateMachine.new(self)

func _unhandled_input(event: InputEvent) -> void:
	self.movement_state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	self.movement_state_machine.process_physics(delta)
	
func _process(_delta: float) -> void: 
	pass
	
# Custom functions
func do_animation(color):
	$ColorRect.color = color
