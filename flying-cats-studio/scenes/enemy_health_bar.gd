extends ProgressBar

@export var enemy: Enemy

func _ready():
	enemy.healthChanged.connect(update)
	update()

func update():
	value = 100
	#value = enemy.currentHealth
	
