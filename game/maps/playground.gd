extends Spatial
#basically a resource dump for projectiles and other disposable items that need a static frame of reference
var last_transform = get_transform()
func _ready():
	pass

var shoot = preload("res://effects/bullet.tscn")
func shoot(transform):
	last_transform = transform
	add_child(shoot.instance(false))

var bullet_hit = preload("res://effects/bullet hit.tscn")
func bullet_hit(transform):
	last_transform = transform
	add_child(bullet_hit.instance(false))

var test = preload("res://maps/common/test box.tscn")
func test_box(transform):
	last_transform = transform
	add_child(test.instance(false))