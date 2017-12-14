extends Spatial
enum {MODE_MAP,MODE_ACTION}
var PLAY_MODE
var chars = []
var active_char
func _ready():
	#make an array of characters, to serialize later
	for char in get_node("chars").get_children():
		chars.append(char)
		char.active_char(false)
	
	set_fixed_process(true)
	
	PLAY_MODE = MODE_MAP
	pass
func _fixed_process(delta):
	if PLAY_MODE == MODE_MAP:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if Input.is_action_pressed("char_fire"):
			var active = false
			for char in chars:
				if active == false:
					if char.selected == true:
						active_char = char
						char.active_char = char.selected
						active = true
					else:
						char.active_char = false
			if active == true:
				PLAY_MODE = MODE_ACTION
				for char in chars:
					char.action_start()
	elif PLAY_MODE == MODE_ACTION:
		for char in chars:
			char.target = active_char
			pass
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
		pass
	if Input.is_key_pressed(KEY_ESCAPE):#debug
		get_tree().quit()