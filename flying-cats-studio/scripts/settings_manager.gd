extends Node

const CONFIG_PATH := "user://settings.cfg"

var video_settings := {
	"resolution": Vector2i(1280, 720), 
	"fullscreen": false, 
	"borderless": false, 
	"vsync": false,
}

var audio_settings := {
	"master_volume": 0.5,
	"music_volume": 0.5, 
	"sfx_volume": 0.5,
}

var controls_settings := {
	"move_up": "W", 
	"move_left": "A",
	"move_down": "S",
	"move_right": "D",
}

var language_settings := {
	"locale": "en",
}

func _save_settings():
	var config := ConfigFile.new()
	
	for key in video_settings:
		config.set_value("video", key, video_settings[key])
		
	for key in audio_settings:
		config.set_value("video", key, audio_settings[key])
		
	for key in controls_settings:
		config.set_value("video", key, controls_settings[key])
		
	for key in language_settings:
		config.set_value("video", key, language_settings[key])
		
	config.save(CONFIG_PATH)
