extends Area2D

@onready var enter = $enter
@onready var conversation = $CanvasLayer/conversation
@onready var note = $CanvasLayer/note

@export var player: CharacterBody2D

func _process(delta):
	note.hide()
	enter.hide()
	for body in get_overlapping_bodies():
		state()
		
		if not player.is_talking:
			note.show()
			enter.show()
			
		if Input.is_action_just_pressed("enteract"):
			conversation.show()
			
func state():
	if conversation.visible:
		player.is_talking = true
	else:
		player.is_talking = false
