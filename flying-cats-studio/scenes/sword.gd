extends Sprite2D
var isHurt: bool = false
@export var enemy: Enemy
@onready var area_2d: Area2D = %Area2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_signals()
	$Area2D/CollisionPolygon2D.disabled = true
	
func connect_signals() -> void:
	%Area2D.connect("body_entered", damage)
	
func damage(body : Node2D) -> void:
	if body is Enemy:
		body.update_health(-100)

func _physics_process(_delta: float) -> void:
	if !isHurt:
		for area in area_2d.get_overlapping_areas():
			if area.name == "HurtBox":
				hurtBySword(Area2D)

func hurtBySword(_area):
	enemy.currentHealth -= 10
