extends Node

#class_name Damageable

signal on_hit(node: Node, damage_taken: int)

@export var health_points = 5 :
	get:
		return health_points
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health_points)
		health_points = value

func update(delta):
	$"../../Label".text = health_points

func hit(dmg):
	health_points -= dmg
	emit_signal("on_hit", get_parent(), dmg)
	if health_points <= 0:
		get_parent().queue_free()
