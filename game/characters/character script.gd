extends KinematicBody
export var current_character = true
export var player_control = true
func _ready():
	set_fixed_process(true)
	set_process(true)
	
var direction
func _fixed_process(delta):
	if current_character == true:
		if player_control == true:
			input_handler()
			apply_character_direction()
	

var character_direction = Vector3(0,0,0)

func input_handler(): #todo change into own script
	if Input.is_key_pressed(KEY_A):
		character_direction.x = -1
	elif Input.is_key_pressed(KEY_D):
		character_direction.x = 1
	else:
		character_direction.x = 0
	if Input.is_key_pressed(KEY_W):
		character_direction.z = -1
	elif Input.is_key_pressed(KEY_S):
		character_direction.z = 1
	else:
		character_direction.z = 0
	character_direction = character_direction.normalized()
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
var camera_speed = 0
var camera_last = Vector2(0,0)
func _process(delta):
	var vp_size = get_viewport().get_rect().size #viewport size; todo detect screen changes and update this value
	var center = vp_size/2
#	camera_look += ((get_viewport().get_mouse_pos() - center)/1000)
	var cursor_pos = get_viewport().get_mouse_pos()
	var cursor_dif = (cursor_pos - center)
	if cursor_dif.abs() > cursor_dif.normalized().abs() * 100:
		camera_speed = 100
	else:
		if camera_speed > 0:
			camera_speed -= 1
		
	camera_speed = clamp(camera_speed,0,100)
	
	cursor_dif = cursor_dif.normalized() * camera_speed
	Input.warp_mouse_pos(center + cursor_dif)
	
	print (cursor_dif)
	print (camera_speed)
#	get_node(".").rotate_y(camera_look.x)
#	get_node("cam base").rotate_x(camera_look.y)
	camera_last = cursor_dif
	

var previous_char_dir = character_direction
var direction_diff_dot = 1
export var speed_limit = 5
var speed_max = speed_limit
var speed_cur = 0
var speed_gain = .015
func apply_character_direction():
	direction_diff_dot = previous_char_dir.dot(character_direction)
#	print(direction_diff_dot) #dot oposite = -1, equals = 1 perpen = 0
	if direction_diff_dot > 0.5:
		speed_max = speed_limit * 1
	elif direction_diff_dot > -.5:
		speed_max = speed_limit * .5
	else:
		speed_max = speed_limit * 0
	speed_cur += speed_gain
#	print(speed_cur)
	speed_cur = clamp(speed_cur,0,speed_max)
#	print(Vector3(0,0,1).normalized().dot(Vector3(1,1,0).normalized())) #dot oposite = -1, equals = 1 perpen = 0
	previous_char_dir = character_direction
	var cam_base = get_node("cam base") 
	var cam_heigh_offset = Vector3(0,3.19891,0)
#	cam_base.set_translation(character_direction * .1 + cam_heigh_offset)
	translate(character_direction * .1 * speed_cur)
