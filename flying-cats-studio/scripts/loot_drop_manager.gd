extends Node

@export var loot_item_scene: PackedScene

func spawn_loot(world_position: Vector2, loot: LootItemInstance):
	if loot: 
		var item = loot_item_scene.instantiate()
		item.loot = loot
		item.global_position = world_position
		get_tree().current_scene.call_deferred("add_child", item)
		
		
		
