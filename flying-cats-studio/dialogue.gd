extends Control

@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton

var bodies := {
	"Player": preload("res://icon.svg"),
	"npc": preload("res://icon2.0.svg")
}

var dialogue_items: Array[Dictionary] = [
	{
		"text": "voihwoivjwoivjveiojwe.",
		"character": bodies["Player"],
	},
	{
		"text": "biwejwevnwevenv.",
		"character": bodies["npc"],
	},
	{
		"text": "nvjwviojweoivjwveoi.",
		"character": bodies["Player"],
	},
	{
		"text": "qwfkevnqkveqko.",
		"character": bodies["npc"],
	},
]
var current_item_index := 0

func _ready() -> void:
	show_text()
	next_button.pressed.connect(advance)

func show_text() -> void:
	var current_item := dialogue_items[current_item_index]
	rich_text_label.text = current_item["text"]
	bodies.texture = current_item["character"]
	
	rich_text_label.visible_ratio = 0.0
	var tween := create_tween()
	var text_appearing_duration: float = current_item["text"].length() / 30.0
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, text_appearing_duration)
	
	
func advance() -> void:
	current_item_index += 1
	if current_item_index == dialogue_items.size():
		get_tree().quit()
	else:
		show_text()
		
