extends Node

@onready var IDLE = $IDLE
@onready var MOVE = $WALK
@onready var HIT = $HIT

@export var can_move = true

signal interrupt_state()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
