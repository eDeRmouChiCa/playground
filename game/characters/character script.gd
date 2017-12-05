extends KinematicBody
export var current_character = true
export var player_control = true
func _ready():
	set_fixed_process(true)
	
var direction
func _fixed_process(delta):
	if current_character == true:
		if player_control == true:
			input_handler()
			apply_character_direction()
	#input handler
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
	character_direction.normalized()

func apply_character_direction():
	
	move(character_direction * .1)