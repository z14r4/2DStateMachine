extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity_value = ProjectSettings.get_setting("physics/2d/default_gravity")

#player input
var movement_input = Vector2.ZERO
var jump_input = false;
var jump_input_actuation
var dash_input = false
#player movement
const SPEED = 140.0
const JUMP_VELOCITY = -400.0
var last_direction = Vector2.RIGHT #upon entering a room, immediately dash right
var num_jumps = 2
#mechanics
var can_dash = true
#states
var current_state = null
var prev_state = null
#nodes
@onready var STATES = $STATES
@onready var Raycasts = $Raycasts

#combat
var health_points = 5
var attack_input = false
var can_attack = false


func _ready():
	for state in STATES.get_children():
		state.STATES = STATES
		state.Player = self
	prev_state = STATES.IDLE
	current_state = STATES.IDLE
		

func _physics_process(delta):
	player_input()
	change_state(current_state.update(delta))
	$Label.text = str(current_state.get_name())
	$Label2.text = str(health_points)
	move_and_slide()


func gravity(delta):
	if not is_on_floor():
		velocity.y += gravity_value * delta

func change_state(input_state):
	if(input_state != null):
		prev_state = current_state
		current_state = input_state
		
		prev_state.exit_state()
		current_state.enter_state()

func get_next_to_wall():
	#checks topright>botright>topleft>botleft
	for raycast in Raycasts.get_children():
		raycast.force_raycast_update()
		if raycast.is_colliding():
			if raycast.target_position.x > 0:
				return Vector2.RIGHT
			else:
				return Vector2.LEFT
	return null

func player_input():
	movement_input = Vector2.ZERO
	jump_input = false
	dash_input = false
	attack_input = false
	
	if Input.is_action_pressed("MoveRight"):
		movement_input.x += 1
	if Input.is_action_pressed("MoveLeft"):
		movement_input.x -= 1
	if Input.is_action_pressed("MoveUp"):
		movement_input.y -= 1
	if Input.is_action_pressed("MoveDown"):
		movement_input.y += 1
	
	if Input.is_action_pressed("Jump"):
		jump_input = true
	if Input.is_action_just_pressed("Jump"):
		jump_input_actuation = true
	else: jump_input_actuation = false
	
	#dash
	if Input.is_action_just_pressed("Dash"):
		dash_input = true
		
	if Input.is_action_just_pressed("Attack"):
		attack_input = true
	
