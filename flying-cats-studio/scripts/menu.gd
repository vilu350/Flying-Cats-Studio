extends Control

@export var menu_button: Button

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _ready():
	menu_button.pressed.connect(_on_menu_pressed)
