extends "state.gd"


func update(delta):
	Player.gravity(delta)
	player_movement()
	if Player.velocity.x == 0 and Player.is_on_floor():
		return STATES.IDLE
	if Player.velocity.y > 0:
		return STATES.FALL
	#_actuation makes it so the spacebar has to be let go and then pressed again, cant hold jump
	if Player.jump_input_actuation and Player.num_jumps > 0:
		return STATES.JUMP
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.attack_input:
		return STATES.ATTACK
	return null
	
func enter_state():
	if Player.is_on_floor():
		Player.can_dash = true
		Player.num_jumps = 2
