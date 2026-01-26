extends CharacterBody2D

#@onready var

@export var starting_dir = Vector2.LEFT

#states
var current_state = null
var prev_state = null
#nodes
@onready var STATES = $STATES

const SPEED = 30
const JUMP_VELOCITY = -400.0
#var hp = $Damageable.health_points

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#func _ready():
#	for state in STATES.get_children():
#		state.STATES = STATES
#		state.Player = self
#	prev_state = STATES.IDLE
#	current_state = STATES.IDLE
#
func update(delta):
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = starting_dir
	if direction:  #&& STATES.check_if_can_move()
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
