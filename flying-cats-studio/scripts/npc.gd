extends Area2D

@onready var conversation: Control = $CanvasLayer/Conversation
#@onready var conversation = $CanvasLayer/conversation
@onready var note = $CanvasLayer/note

#@export var player: CharacterBody2D
@onready var player: Player = %Player

var player_in_range := false

func _ready():
	conversation.hide()
	
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(_delta):
	#note.hide()
	for body in get_overlapping_bodies():
		state()
		
		#if not player.is_talking:
			#note.show()
	if player_in_range:
		
		if Input.is_action_just_pressed("enteract"):
			conversation.show()
			
	else:
		conversation.hide()
	
	player.is_talking = conversation.visible
		
func state():
	if conversation.visible:
		player.is_talking = true
	else:
		player.is_talking = false

func _on_body_entered(body):
	if body == player:
		player_in_range = true
		
func _on_body_exited(body):
	if body == player:
		player_in_range = false
		
