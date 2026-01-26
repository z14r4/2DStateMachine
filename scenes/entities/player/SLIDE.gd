extends "state.gd"


@export var climb_speed = 50
@export var slide_friction = .5

func update(delta):
	slide_movement(delta)
	if Player.is_on_floor():
		return STATES.IDLE
	if Player.get_next_to_wall() == null:
		return STATES.FALL
	if Player.jump_input_actuation:
		return STATES.JUMP
	return null

func slide_movement(delta):
	player_movement()
	Player.gravity(delta)
	Player.velocity.y *= slide_friction
		
func enter_state():
	Player.can_dash = true
	Player.num_jumps = 2
