extends "state.gd"


func update(delta):
	Player.gravity(delta)
	if Player.movement_input.x != 0:
		return STATES.MOVE
	if Player.jump_input_actuation:
		return STATES.JUMP
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.attack_input:
		return STATES.ATTACK
	return null
	
func enter_state():
	if Player.is_on_floor():
		Player.can_dash = true
		Player.num_jumps = 2
