extends CharacterBody2D

class_name Enemy
signal healthChanged

@onready var _hit_box: Area2D = %HitBox

@export var maxHealth = 30
@onready var currentHealth: int = maxHealth


@export var max_speed := 1000.0
@export var acceleration := 1100.0
@export var deceleration := 900.0
@export var loot_scene: PackedScene

var health:float = 3.0

func _physics_process(delta: float) -> void:
	var direction := global_position.direction_to(get_global_player_position())
	var distance := global_position.distance_to(get_global_player_position())
	var speed := max_speed if distance > 100 else max_speed * distance / 100
	var desired_velocity := direction * speed
	velocity = velocity.move_toward(desired_velocity, acceleration * delta)
	move_and_slide()

func get_global_player_position() -> Vector2:
	return get_tree().root.get_node("TestMap/Player").global_position

func take_damage(weapon_damage: float):
	# Spawn the gem
	var new_gem = loot_scene.instantiate()
	new_gem.global_position = global_position
	get_tree().current_scene.call_deferred("add_child", new_gem)
	health -= weapon_damage
	
	if health <= 0.0:
		queue_free()
	
	# Die
	queue_free()
	
func update_health(amount):
	currentHealth -= amount
	
