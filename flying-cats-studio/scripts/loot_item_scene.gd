extends Sprite2D

@export var loot : LootItemInstance

func _ready():
	if loot:
		texture = loot.base.icon 
