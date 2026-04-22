extends ProgressBar

@export var enemy: Enemy

func _ready():
	enemy.healthChanged.connect(update)
	update()

func update():
	value = enemy.currentHealth #* 100 / enemy.maxHealth
	
