extends RigidBody

func _ready():
	set_transform(get_node("../").last_transform)
	set_fixed_process(true)
	pass
var life = 100
func _fixed_process(delta):
	life -= 1
	if life <= 0:
		queue_free()
	var cobod = get_colliding_bodies()
	if cobod != []: #collision detected
		for a in cobod:
			if a.is_in_group("char"): #todo character specific actions
				a.status_cur_hp -= 1
				if a.status_cur_hp <= 0:
					a.hide()
				pass
		get_node("../").bullet_hit(get_transform())
		queue_free()
	translate(Vector3(0,0,-2))