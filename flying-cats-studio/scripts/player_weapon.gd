extends Sprite2D

class_name Enemy

func _ready() -> void:
	connect_signals()
	


func connect_signals() -> void:
	%Area2D.connect("body_entered", damage)
	
func damage(body: Node2D) -> void:
	if body is Enemy:
		body.update_health(-1)
		
