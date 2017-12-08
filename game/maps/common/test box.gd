#extends RigidBody
#
#func _ready():
#	set_fixed_process(true)
#var count_down = 20
#func _fixed_process(delta):
#	count_down -= 1
#	if count_down <= 0:
#		set_sleeping(true)
#		print("sleep")
#	pass