extends Control

var current_scene

@export var hotbar : HBoxContainer

func _on_hotbar_equip(item: Item) -> void:
	if current_scene
