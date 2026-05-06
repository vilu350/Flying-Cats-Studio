extends CanvasLayer

func _ready():
	visible = false
	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.keycode == KEY_E and event.is_pressed():
			visible = !visible
			
