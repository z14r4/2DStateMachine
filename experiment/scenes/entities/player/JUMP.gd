extends "state.gd"


func update(delta):
	Player.gravity(delta);
	player_movement();
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.jump_input_actuation and Player.num_jumps > 0:
		return STATES.JUMP
	if Player.attack_input:
		return STATES.ATTACK
	return null
	
func enter_state():
	Player.velocity.y = Player.JUMP_VELOCITY
	Player.num_jumps -= 1
