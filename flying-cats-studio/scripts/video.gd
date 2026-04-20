extends VBoxContainer

@export var resolution_option: OptionButton
@export var fullscreen_check: CheckBox
@export var borderless_check: CheckBox
@export var vsync_check: CheckBox


func _ready():
	var resolutions = [
		Vector2i(1920, 1080),
		Vector2i(1600, 900),
		Vector2i(1280, 720),
		Vector2i(640, 360),
		Vector2i(320, 180)
	]
	for res in resolutions: 
		resolution_option.add_item("%dx%d" % [res.x, res.y])
		
		load_current_settings()

func load_current_settings():
	var mode = DisplayServer.window_get_mode()
	fullscreen_check.button_pressed = mode == DisplayServer.WINDOW_MODE_FULLSCREEN
	borderless_check.button_pressed = DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS)
	vsync_check.button_pressed = DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_ENABLED
	
	var window_size = DisplayServer.window_get_size()
	for i in range(resolution_option.item_count):
		var res_text = resolution_option.get_item_text(i)
		var parts = res_text.split("x")
		if parts.size() == 2 and int(parts[0]) == window_size.x and int(parts[1]) == window_size.y: 
			resolution_option.select(i)
			break
