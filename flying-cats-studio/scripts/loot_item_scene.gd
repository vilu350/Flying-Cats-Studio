extends Sprite2D

@export var loot : LootItemInstance

func _ready():
	if loot:
		texture = loot.base.icon 


func _on_player_entered(body: Node2D) -> void:
	InventoryManager.add_item(loot)
	print("taken by :", body.name)
	queue_free()
