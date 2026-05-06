extends Node

const GRID_SIZE := Vector2i(8, 4)

var grid := {} #Vector2i -> LootItemInstance 
var grid_ui: InventoryGridUI

func register_ui(ui: InventoryGridUI):
	grid_ui = ui
	
func can_place(item: LootItemInstance, pos: Vector2i) -> bool:
	for y in item.base.size.y:
		for x in item.base.size.x:
			var p := pos + Vector2i(x, y)
			if p.x < 0 or p.y < 0:
				return false
			if p.x >= GRID_SIZE.x or p.y >= GRID_SIZE.y:
				return false
			if grid.has(p):
				return false
	return true
	
func place(item: LootItemInstance, pos: Vector2i):
	for y in item.base.size.y:
		for x in item.base.size.x:
			grid[pos + Vector2i(x, y)] = item
			
func clear_item(item: LootItemInstance):
	for k in grid.keys():
		if grid[k] == item:
			grid.erase(k)  
			
func add_item(item: LootItemInstance) -> bool:
	for y in GRID_SIZE.y:
		for x in GRID_SIZE.x:
			var pos := Vector2i(x, y)
			if can_place(item, pos):
				place(item, pos)
				grid_ui.spawn_item_ui(item, pos)
				return true
	return false
	
	
