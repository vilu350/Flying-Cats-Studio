extends Control

@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var action_buttons_v_box_container: VBoxContainer = %ActionButtonsVBoxContainer

var bodies := {
	"Player": preload("res://icon.svg"),
	"npc": preload("res://icon2.0.svg")
}

@export var dialogue_items: Array[DialogueItem] = [
	{
		"text": "voihwoivjwoivjveiojwe.",
		"character": bodies["Player"],
		"choices": {
			"Let me sleep a little longer": 2,
			"Let's do it!": 1,
		},
	},
	{
		"text": "biwejwevnwevenv.",
		"character": bodies["npc"],
		"choices": {
			"I will do my best": 3,
			"No, let me go back to sleep": 2,
		},
	},
	{
		"text": "nvjwviojweoivjwveoi.",
		"character": bodies["Player"],
		"choices": {
			"No, really, let me go back to sleep": 0,
			"Alright, I'll try": 1,
		},
	},
	{
		"text": "qwfkevnqkveqko.",
		"character": bodies["npc"],
		"choices": {"Okay! (Quit)": - 1},
	},
]

func _ready() -> void:
	show_text(0)

func show_text(current_item_index: int) -> void:
	var current_item := dialogue_items[current_item_index]
	rich_text_label.text = current_item["text"]
	bodies.texture = current_item["character"]
	create_buttons(current_item["choices"])
	
	rich_text_label.visible_ratio = 0.0
	var tween := create_tween()
	var text_appearing_duration: float = current_item["text"].length() / 30.0
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, text_appearing_duration)
	for button: Button in action_buttons_v_box_container.get_children():
		button.disabled = true
	tween.finished.connect(func() -> void:
		for button: Button in action_buttons_v_box_container.get_children():
			button.disabled = false
	)
	
	
func create_buttons(choices_data: Dictionary) -> void:
	for button in action_buttons_v_box_container.get_children():
		button.queue_free()
	# We loop over all the dictionary keys
	for choice_text in choices_data:
		var button := Button.new()
		action_buttons_v_box_container.add_child(button)
		button.text = choice_text
		var target_line_idx: int = choices_data[choice_text]
		if target_line_idx == - 1:
			button.pressed.connect(get_tree().quit)
		else:
			button.pressed.connect(show_text.bind(target_line_idx))
