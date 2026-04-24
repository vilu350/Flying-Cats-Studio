extends VBoxContainer

@export var up_button: Button
@export var left_button: Button
@export var down_button: Button
@export var right_button: Button

const ACTIONS = {
	"up": "move_up", 
	"left": "move_left",
	"down": "move_down",
	"right": "move_right"
}
	
var waiting_for_input: String = ""

func _ready():
	_update_button_labels()
	
	up_button.pressed.connect(_on_rebind_button_pressed.bind("up"))
	left_button.pressed.connect(_on_rebind_button_pressed.bind("left"))
	down_button.pressed.connect(_on_rebind_button_pressed.bind("down"))
	right_button.pressed.connect(_on_rebind_button_pressed.bind("right"))

func _get_button(direction: String) -> Button:
	match direction:
		"up": return up_button
		"left": return left_button
		"down": return down_button
		"right": return right_button
		_: return null
		
func _update_button_label(direction: String):
	var action_name = ACTIONS[direction]
	var events = InputMap.action_get_events(action_name)
	
	var label_text = "Unassigned"
	
	if events.size() > 0:
		var event = events[0]
		if event is InputEventKey: 
			if event.keycode != 0:
				label_text = OS.get_keycode_string(event.keycode)
			elif event.physical_keycode != 0: 
				label_text = OS.get_keycode_string(event.physical_keycode)
	
	var btn = _get_button(direction)
	btn.text = "%s" % [label_text]
	
func _update_button_labels():
	for dir in ACTIONS.keys():
		_update_button_label(dir)
		
func _on_rebind_button_pressed(direction: String):
	waiting_for_input = direction
	var btn = _get_button(direction)
	btn.text = ". . ."
	set_process_input(true)
	
func _input(event):
	if waiting_for_input == "":
		return
		
	if event is InputEventKey and event.pressed:
		var direction = waiting_for_input
		var action_name = ACTIONS[direction]
		
		InputMap.action_erase_events(action_name)
		InputMap.action_add_event(action_name, event)
		
		_update_button_label(direction)
		
		waiting_for_input = ""
		set_process_input(false)
