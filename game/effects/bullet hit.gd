extends Particles

func _ready():
	set_transform(get_node("../").last_transform)
	set_fixed_process(true)
	pass
var life = 20
func _fixed_process(delta):
	life -= 1
	if life <= 0:
		queue_free()