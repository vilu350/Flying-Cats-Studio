@tool
extends Control

@export var dialogue_items: Array[DialogueItem] = []:
	set = set_dialogue_items
@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var action_buttons_v_box_container: VBoxContainer = %ActionButtonsVBoxContainer
@onready var body: TextureRect = %Body

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	show_text(0)

func show_text(current_item_index: int) -> void:
	var current_item := dialogue_items[current_item_index]
	rich_text_label.text = current_item.text
	body.texture = current_item.character
	create_buttons(current_item.choices)
	
	rich_text_label.visible_ratio = 0.0
	
	var tween := create_tween()
	var text_appearing_duration := (current_item["text"] as String).length() / 30.0
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, text_appearing_duration)
	for button: Button in action_buttons_v_box_container.get_children():
		button.disabled = true
	tween.finished.connect( func() -> void:
		for button: Button in action_buttons_v_box_container.get_children():
			button.disabled = false
	)
	
	
func create_buttons(choices_data: Array[DialogueChoice]) -> void:
	for button in action_buttons_v_box_container.get_children():
		button.queue_free()
	for choice in choices_data:
		var button := Button.new()
		action_buttons_v_box_container.add_child(button)
		button.text = choice.text
		if choice.is_quit == true:
			button.pressed.connect(get_tree().quit)
		else:
			var target_line_idx := choice.target_line_idx
			button.pressed.connect(show_text.bind(target_line_idx))

func set_dialogue_items(new_dialogue_items: Array[DialogueItem]) -> void:
	for index in new_dialogue_items.size():
		if new_dialogue_items[index] == null:
			new_dialogue_items[index] = DialogueItem.new()
	dialogue_items = new_dialogue_items
	update_configuration_warnings()
	
func _get_configuration_warnings() -> PackedStringArray:
	if dialogue_items.is_empty():
		return ["You need at least one dialogue item for the dialogue system to work."]
	return []
	
