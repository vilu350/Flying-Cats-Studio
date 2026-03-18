extends Area2D

@export var xp_amount = 10



func _on_body_entered(body: Node2D) -> void:
	# If the player touches this, give them XP
	if body.has_method("gain_xp"):
		print("Experience gained: " + str(xp_amount))
		body.gain_xp(xp_amount)
		queue_free() # Remove the gem
	
