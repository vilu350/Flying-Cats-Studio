extends Control

@export var dialogue_items: Array[SlideShowEntry] = []
var current_item_index := 0

@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton
@onready var body: TextureRect = %Body

func _ready() -> void:
	show_text()
	next_button.pressed.connect(advance)

func show_text() -> void:
	var current_item := dialogue_items[current_item_index]
	rich_text_label.text = current_item.text
	body.texture = current_item.character
	rich_text_label.visible_ratio = 0.0
	var tween := create_tween()

	var text_appearing_duration := (current_item["text"] as String).length() / 30.0
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, text_appearing_duration)

func advance() -> void:
	current_item_index += 1
	if current_item_index == dialogue_items.size():
		get_tree().quit()
	else:
		show_text()
