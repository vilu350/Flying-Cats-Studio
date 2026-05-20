extends Control

@onready var name_label: Label = $ColorRect/name
@onready var word_label: Label = $ColorRect/word
#@onready var continue: Label = $ColorRect/continue

@export var dialogue_words: Array[String] = []
@export var dialogue_names: Array[String] = []


#@onready var word_label = $board/word
#@onready var name_label = $board/name
#@onready var icon_rect = $board/frame/TextureRect



#@export_group("conversation")
#@export_multiline var word: Array[String]
#@export var _name: Array[String]
#@export var _icon: Array[Texture]

var current_step = 0

func _ready():
	hide()
	
func start_dialogue():
	current_step = 0
	show()
	update_dialogue()
	
func _input(event):
	if visible and event.is_action_pressed("click"):
		current_step += 1
		
		if current_step >= dialogue_words.size():
			hide()
			current_step = 0
		else:
			update_dialogue()
	
func update_dialogue():
	word_label.text = dialogue_words[current_step]
	
	if current_step < dialogue_names.size():
		name_label.text = dialogue_names[current_step]
	
#func _process(delta):
	
	#conversation_queue()
	
	#if Input.is_action_just_pressed("click"):
		#current_step += 1
		
#func conversation_queue():
	
	#if current_step < word.size():
		#word_label.text = word[current_step]
	#else:
		#current_step = 0
		#hide()
		
	#if current_step < _name.size():
		#name_label.text = _name[current_step]
	#else:
		#current_step = 0
		#hide()
