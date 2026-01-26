extends Node2D

@export var damage: int = 1
#func _on_area_2d_area_entered(area):
#	print("hit")
#	pass # Replace with function body.

func _ready():
	pass

func _on_area_2d_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			child.hit(damage)
			print(body.name + " took " + str(damage))
