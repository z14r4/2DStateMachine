extends Node

@export var damageable: Damageable
@export var char_state_machine : Node

func _ready():
	pass
	damageable.connect("on_hit", on_damageable_hit)
	
func on_damageable_hit(node: Node, damage_amount: int):
	emit_signal("interrupt_state", self)
