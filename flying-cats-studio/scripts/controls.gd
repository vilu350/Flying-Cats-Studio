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
