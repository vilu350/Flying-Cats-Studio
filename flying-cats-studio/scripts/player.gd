extends CharacterBody2D

class_name Player

signal healthChanged

@export var speed: int = 500
@onready var animations = $AnimationPlayer
@onready var effects: Node2D = $Effects
@export var max_speed := 800.0
@export var acceleration := 1200.0
@export var deceleration := 1100.0
@onready var hurt_box: Area2D = $HurtBox
@onready var hurt_timer: Timer = $HurtTimer
@onready var sword: Sprite2D = $Sprite2D/Sword

@export var maxHealth = 30
@onready var currentHealth: int = maxHealth

var current_look_dir = "left"

var can_slash: bool = true
@export var slash_time: float = 0.2
@export var sword_return_time: float = 0.5
@export var weapon_damage: float = 50.0

@export var knockbackPower: int = 500

var lastAnimDirection: String = "Down"
var isHurt: bool = false
var isAttacking: bool = false

func _ready():
	#effects.play("RESET")
	pass
	
func handleInput():
	pass
	
	#if Input.is_action_just_pressed("attack"):
		#attack()
		
func attack():
	animations.play("attack" + lastAnimDirection)
	isAttacking = true
	sword.enable()
	await animations.animation_finished
	sword.disable()
	isAttacking = false		
			
func updateAnimation():
	if isAttacking: return
	
	
	
	#if velocity.length() == 0:
		#if animations.is_playing():
			#animations.stop()
			
	#else:
		#var direction = "Down"
		#if velocity.x < 0: direction = "Left"
		#elif velocity.x > 0: direction = "Right"
		#elif velocity.y < 0: direction = "Up"
		
		#animations.play("walk" + direction)
		#lastAnimDirection = direction

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var has_input_direction := direction.length() > 0.0
	if has_input_direction:
		var desired_velocity := direction * max_speed
		velocity = velocity.move_toward(desired_velocity, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	move_and_slide()
	handleInput()
	#updateAnimation()
	if !isHurt:
		for area in hurt_box.get_overlapping_areas():
			if area.name == "HitBox":
				hurtByEnemy(area)
	if current_look_dir == "right" and get_global_mouse_position().x < global_position.x:
		current_look_dir = "left"
	elif current_look_dir == "left" and get_global_mouse_position().x > global_position.x:
		current_look_dir = "right"
		
	
	if Input.is_action_pressed("attack") and can_slash:
		$Sprite2D/Sword/AnimationPlayer.speed_scale = $Sprite2D/Sword/AnimationPlayer.get_animation("slash").length / slash_time
		$Sprite2D/Sword/AnimationPlayer.play("slash")
		can_slash = false
	
func spawn_slash():
	pass
	
func hurtByEnemy(area):
	currentHealth -= 10
	if currentHealth < 0:
		currentHealth = maxHealth
		
	isHurt = true
	healthChanged.emit()
	
	knockback(area.get_parent().velocity)
	#effects.play("hurtBlink")
	hurt_timer.start()
	await hurt_timer.timeout
	#effects.play("RESET")
	isHurt = false
	
func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "slash":
		$Sprite2D/Sword/AnimationPlayer.speed_scale = $Sprite2D/Sword/AnimationPlayer.get_animation("sword_return").length / sword_return_time
		$Sprite2D/Sword/AnimationPlayer.play("sword_return")
	else:
		can_slash = true
