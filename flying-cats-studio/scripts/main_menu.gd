extends Control

@export var menu: VBoxContainer
@export var main_settings: VBoxContainer
@export var video_settings: VBoxContainer
@export var audio_settings: VBoxContainer
@export var control_settings: VBoxContainer
@export var language_settings: VBoxContainer
@export var back_button: Button

@export var video_button: Button
@export var audio_button: Button
@export var controls_button: Button
@export var language_button: Button

var nav_stack: Array[Control] = []
var current_panel

func _show_panel(panel: Control):
	panel.visible = true 
	
func _update_back_button():
	back_button.visible = nav_stack.size() > 0
