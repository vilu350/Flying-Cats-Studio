extends Control
class_name InventorySlot

@export var grid_pos: Vector2i
@onready var highlight := $Highlight

func set_valid(valid: bool):
	highlight.color = Color(0,1,0,0.3) if valid else Color(1,0,0,0.3)
	
func clear():
	highlight.color = Color("1d1d1d", 0.8)
	
