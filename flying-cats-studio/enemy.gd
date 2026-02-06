extends CharacterBody2D
#left off at M9L13 half way down
@onready var _hit_box: Area2D = %HitBox

@export var max_speed := 1000.0
@export var acceleration := 1100.0
@export var deceleration := 900.0

func _physics_process(delta: float) -> void:
	var direction := global_position.direction_to(get_global_player_position())
	var distance := global_position.distance_to(get_global_player_position())
	var speed := max_speed if distance > 100 else max_speed * distance / 100
	var desired_velocity := direction * speed
	velocity = velocity.move_toward(desired_velocity, acceleration * delta)
	move_and_slide()

func get_global_player_position() -> Vector2:
	return get_tree().root.get_node("TestMap/Player").global_position
