extends "state.gd"

@onready var attack_anim = $"../../AttackNode/AnimationPlayer"
@onready var attack_node = $"../../AttackNode"
@onready var attack_area = $"../../AttackNode/Area2D"


func update(delta):
	Player.gravity(delta);
	player_movement();
	if Player.movement_input.x != 0:
		return STATES.MOVE
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.velocity.x == 0 and Player.is_on_floor():
		return STATES.IDLE
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.jump_input_actuation and Player.num_jumps > 0:
		return STATES.JUMP
	return null

func enter_state():
	if(Player.movement_input == Vector2.UP):
		attack_node.set_position(Vector2(0, -19))
	elif(Player.movement_input == Vector2.DOWN):
		attack_node.set_position(Vector2(0, 19))
	elif(Player.last_direction == Vector2.RIGHT):
		attack_node.set_position(Vector2(19, 0))
	elif(Player.last_direction == Vector2.LEFT):
		attack_node.set_position(Vector2(-19, 0))
	attack_anim.play("attack")

func exit_state():
	pass


func _on_area_2d_area_entered(area):
	if(area.is_in_group("Enemy") and Player.movement_input == Vector2.DOWN):
		Player.velocity = Vector2(0, -350)
