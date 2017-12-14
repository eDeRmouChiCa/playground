extends RigidBody

export(bool) var active_char=false

var _is_loaded = false

	#keyboar actions
var action_forward="char_front"
var action_backward="char_back"
var action_left="char_left"
var action_right="char_right"
#var action_jump="char_jump"
var action_fire="char_fire"
var action_reload="char_reload"
#var action_use="char_use"

export (int) var status_max_hp = 100
var status_cur_hp = status_max_hp

export (int) var weapon_magazine = 30
export (float) var weapon_rate_of_fire = .05
export (float) var weapon_reload_speed = 20.0
export (int) var weapon_range = 20
export (int) var weapon_damage = 100

###############################################################################

func _ready():
	_is_loaded = true
	
	pass
func action_start():
	set_fixed_process(true)
	active_char = selected
	active_char(active_char)
	
func action_end():
	set_fixed_process(false)
	active_char = false
	active_char(active_char)
	pass
func _fixed_process(delta):
	update_gui()
	if active_char:
		char_movement(delta)
		fire += .05
		if fire >= 1:
			if Input.is_action_pressed("char_fire"):
				shoot()
				fire = 0
	else:
		char_turret()
	
	pass

var selected = false
func _mouse_enter():
	selected = true
func _mouse_exit():
	selected = false

var yaw = 0
var pitch = 0
export(float) var view_sensitivity = 0.3
func _input(event):
	if event.type == InputEvent.MOUSE_MOTION:
		yaw = fmod(yaw - event.relative_x * view_sensitivity, 360)
		pitch = max(min(pitch - event.relative_y * view_sensitivity, 89), -89)
		get_node("cam yaw").set_rotation(Vector3(0, deg2rad(yaw), 0))
		get_node("cam yaw/cam support").set_rotation(Vector3(deg2rad(pitch), 0, 0))
		
		var length = (-pitch + 90)/90
		var ray = get_node("cam yaw/cam support/cam distance")
		ray.set_cast_to(Vector3(0,0,length))
		if ray.is_colliding():
			var ray_col_dif = ray.get_collision_point() - ray.get_global_transform().origin
			length = ray_col_dif.length()
		var camera = get_node("cam yaw/cam support/camera")
		camera.set_translation(Vector3(0,0,length))
		
	pass
func char_movement(delta):
	#get camera rotation and input, then walk in relative direction
	var aim = get_node("cam yaw/cam support").get_global_transform().basis
	var direction = Vector3()
	if Input.is_action_pressed(action_forward):
		direction -= aim[2]
#		direction.z -= 1
	if Input.is_action_pressed(action_backward):
		direction += aim[2]
#		direction.z += 1
	if Input.is_action_pressed(action_left):
		direction -= aim[0]
#		direction.x -= 1
	if Input.is_action_pressed(action_right):
		direction += aim[0]
#		direction.x += 1
	direction.y = 0
	direction=direction.normalized()
	translate(direction/4)
	pass
var target = self #get set by logic.gd
var fire = 0
func char_turret():
	fire += weapon_rate_of_fire
	if fire >= 1:
		shoot()
		fire = 0
	var look_at = target.get_transform().origin
	look_at.y = 0
	look_at(look_at,Vector3(0,1,0))
	pass
func shoot():
	get_node("../../playground").shoot(get_node("cam yaw/cam support/shoot ray").get_global_transform())
	pass
func active_char(active):
	if active == true:
		set_process_input(true)
		get_node("cam yaw/cam support/camera").make_current()
	else:
		set_process_input(false)
		get_node("cam yaw/cam support/camera").clear_current()
		pass
func update_gui():
	var self_hp = get_node("cam yaw/cam support/camera/self hp")
	self_hp.set_max(status_max_hp)
	self_hp.set_val(status_cur_hp)
	var other_hp = get_node("cam yaw/cam support/camera/other hp")
	var shoot_ray = get_node("cam yaw/cam support/shoot ray")
	if shoot_ray.is_colliding():
		var aimed_char = shoot_ray.get_collider()
		if aimed_char.is_in_group("char"):
			print(aimed_char.status_cur_hp)
			other_hp.set_max(aimed_char.status_max_hp)
			other_hp.set_val(aimed_char.status_cur_hp)