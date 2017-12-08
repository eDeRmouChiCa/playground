extends KinematicBody
export var current_character = true
export var player_control = true
func _ready():
	set_fixed_process(true)
	set_process(true)
	Input.warp_mouse_pos(get_viewport().get_rect().size / 2)
	
var direction
func _fixed_process(delta):
	get_node("cam base/cam target/camera/cpu").set_text(str(1/delta))
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
	
	if Input.is_mouse_button_pressed(1):
		get_node("../../").get_node("playground").shoot(get_node("cam base/cam target").get_global_transform())
	camera_look()
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()


var camera_speed = 0
var camera_last = Vector2(0,0)
func _process(delta):
	get_node("cam base/cam target/camera/gpu").set_text(str(1/delta))
	pass
#	var vp_size = get_viewport().get_rect().size #viewport size; todo detect screen changes and update this value
#	var center = vp_size/2
#	var cursor_pos = get_viewport().get_mouse_pos()
#	var cursor_dif = (cursor_pos - center)
#	#cursor_dif = vector2_slowdown(cursor_dif, 13)
#	cursor_dif = vector2_slowdown(cursor_dif, 3)
#	Input.warp_mouse_pos(center + cursor_dif)
#	get_node(".").rotate_y(cursor_dif.x * .03)
#	get_node("cam base").rotate_x(cursor_dif.y * .03)

func camera_look():
	var vp_size = get_viewport().get_rect().size #viewport size; todo detect screen changes and update this value
	var center = vp_size/2
	var cursor_pos = get_viewport().get_mouse_pos()
	var cursor_dif = (cursor_pos - center).normalized() * 2
	var key_dif = Vector2(0,0)
	if Input.is_key_pressed(KEY_LEFT):
		key_dif.x = -1
	elif Input.is_key_pressed(KEY_RIGHT):
		key_dif.x = 1
	if Input.is_key_pressed(KEY_UP):
		key_dif.y = -1
	elif Input.is_key_pressed(KEY_DOWN):
		key_dif.y = 1

#	#cursor_dif = vector2_slowdown(cursor_dif, 13)
#	cursor_dif = vector2_slowdown(cursor_dif, 3)
	get_node(".").rotate_y(deg2rad((cursor_dif.x + key_dif.x)))
	get_node("cam base").rotate_x(deg2rad(cursor_dif.y + key_dif.y))
	Input.warp_mouse_pos(center)

func vector2_slowdown(vector2, magnitude): #linear slow down #todo squared and easing
	if vector2.abs() > vector2.abs().normalized() * magnitude:
		vector2 = vector2.normalized() * magnitude
	if vector2.x != 0:
		if vector2.x < -1:
			vector2.x += 1
		elif vector2.x > 1:
			vector2.x -= 1
		else:
			vector2.x = 0
	if vector2.y != 0:
		if vector2.y < -1:
			vector2.y += 1
		elif vector2.y > 1:
			vector2.y -= 1
		else:
			vector2.y = 0
	return vector2
func vector3_slowdown(vector3, magnitude): #linear slow down #todo squared and easing
	if vector3.abs() > vector3.abs().normalized() * magnitude:
		vector3 = vector3.normalized() * magnitude
	if vector3.x != 0:
		if vector3.x < -1:
			vector3.x += 1
		elif vector3.x > 1:
			vector3.x -= 1
		else:
			vector3.x = 0
	if vector3.y != 0:
		if vector3.y < -1:
			vector3.y += 1
		elif vector3.y > 1:
			vector3.y -= 1
		else:
			vector3.y = 0
	if vector3.z != 0:
		if vector3.z < -1:
			vector3.z += 1
		elif vector3.z > 1:
			vector3.z -= 1
		else:
			vector3.z = 0
	return vector3

var previous_char_dir = character_direction
var current_character_direction = Vector3(0,0,0)
var direction_diff_dot = 1
export var speed_limit = 35
var speed_max = speed_limit
var speed_cur = 0
var speed_gain = .015
func apply_character_direction():
	direction_diff_dot = previous_char_dir.dot(character_direction)
	if direction_diff_dot > 0.5:
		speed_max += 1
	elif direction_diff_dot > -.5:
		speed_max += 0.5
	else:
		speed_max = 0
	current_character_direction += character_direction * speed_limit
	current_character_direction = vector3_slowdown(current_character_direction,speed_limit)
	previous_char_dir = character_direction
	translate(current_character_direction * .007)