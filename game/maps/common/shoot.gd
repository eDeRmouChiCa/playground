extends RigidBody

func _ready():
	set_transform(get_node("../").last_transform)
	set_fixed_process(true)
var countdown = 200
func _fixed_process(delta):
	countdown -= 1
	if countdown <= 0:
		queue_free()
	elif get_colliding_bodies() != []:
		get_node("../").test_box(get_transform())
		queue_free()
	translate(Vector3(0,0,-1) * .10)
	pass