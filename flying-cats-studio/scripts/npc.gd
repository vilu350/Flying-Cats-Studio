extends Area2D

var player_inside := false

@onready var enter = $enter
@onready var conversation = $CanvasLayer/conversation
@onready var note = $"CanvasLayer/note"

@export var player: CharacterBody2D

func _ready():
	enter.hide()
	note.hide()
	conversation.hide()

func _process(delta):
	
	if player_inside and !player.is_talking:
		enter.show()
		note.show()
		
		if Input.is_action_just_pressed("enteract"):
			conversation.show()
			player.is_talking = true
			
	else:
		enter.hide()
		note.hide()
	if !conversation.visible:
		player.is_talking = false
		
		#for body in get_overlapping_bodies():
			#state()
		
			#if not player.is_talking:
				#note.show()
				#enter.show()
			
			#if Input.is_action_just_pressed("enteract"):
				#conversation.show()
			
func _on_body_entered(body):
	if body == player:
		player_inside = true
		
func _on_body_exited(body):
	if body == player:
		player_inside = false
		
		enter.hide()
		note.hide()
	

			
			
#func state():
	#if conversation.visible:
		#player.is_talking = true
	#else:
		#player.is_talking = false
