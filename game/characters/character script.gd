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
var previous_char_dir = character_direction
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
	character_direction.normalized()
	
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()

onready var vp_size = get_viewport().get_rect().size #viewport size
var camera_look = Vector2(0,0)
func _process(delta):
	var offset = vp_size/2
	var differency = get_viewport().get_mouse_pos() - offset
	camera_look += differency
	get_viewport().warp_mouse(offset)
	get_node(".").rotate_y(camera_look.x /300)
	get_node("cam base").rotate_x(camera_look.y / 300)
	
	camera_look = Vector2(0,0)


func apply_character_direction():
	var cam_base = get_node("cam base") 
	var cam_heigh_offset = Vector3(0,3.19891,0)
	cam_base.set_translation(character_direction * .1 + cam_heigh_offset)
	translate(character_direction * .1)
