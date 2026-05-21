extends CanvasLayer

func _ready():
	visible = false
	
func _unhandled_input(event):
	if Input.is_action_just_pressed("inventory"):
		visible = !visible
			
