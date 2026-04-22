extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_signals()
	$Area2D/CollisionPolygon2D.disabled = true
	
func connect_signals() -> void:
	%Area2D.connect("body_entered", damage)
	
func damage(body : Node2D) -> void:
	if body is Enemy:
		body.update_health(-99)


		
