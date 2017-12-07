extends Spatial
#basically a resource dump for projectiles and other disposable items that need a static frame of reference
var last_transform = get_transform()
func _ready():
	pass

var shoot = preload("res://maps/common/shoot.tscn")
func shoot(transform):
	last_transform = transform
	add_child(shoot.instance(true))
	print ("shoot")