extends Control

@onready var word_label = $board/word
@onready var name_label = $board/name
@onready var icon_rect = $board/frame/TextureRect

@export_group("conversation")
@export_multiline var word: Array[String]
@export var _name: Array[String]
@export var _icon: Array[Texture]

var current_step = 0

func _ready():
	hide()
	
func _process(delta):
	
	conversation_queue()
	
	if Input.is_action_just_pressed("click"):
		current_step += 1
		
func conversation_queue():
	
	if current_step < word.size():
		word_label.text = word[current_step]
	else:
		current_step = 0
		hide()
		
	if current_step < _name.size():
		name_label.text = _name[current_step]
	else:
		current_step = 0
		hide()
