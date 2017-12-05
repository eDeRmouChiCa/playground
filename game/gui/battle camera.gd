#extends Camera
#export var mode = 0
#
#func _ready():
#	set_process(true)
#	set_fixed_process(true)
#
#func _fixed_process(delta):
#	pass
#
#onready var vp_size = get_viewport().get_rect().size #viewport size
#func _process(delta):
#	var offset = vp_size/2
#	var differency = get_viewport().get_mouse_pos()
#	get_viewport().warp_mouse(offset)
#	
#	if Input.is_key_pressed(KEY_ESCAPE):
#		get_tree().quit()