extends RigidBody

func _ready():
	set_transform(get_node("../").last_transform)
	set_fixed_process(true)
var countdown = 200
func _fixed_process(delta):
	countdown -= 1
	get_node("cube").set_scale(Vector3(1,1,1) *1 / countdown)
	get_node("TestCube").set_scale(Vector3(1,1,1) *1 / countdown)
	if countdown <= 0:
		queue_free()
	translate(Vector3(0,0,-1) * 10)
	pass