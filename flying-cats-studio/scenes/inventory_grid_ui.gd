extends Control
class_name InventoryGridUI

@export var slot_scene: PackedScene
@export var item_scene: PackedScene

const CELL_SIZE := 32

var slots: Array[InventorySlot] = []

func _ready():
	InventoryManager.register_ui(self)
	_create_slots()
	
func _create_slots():
	for y in range(InventoryManager.GRID_SIZE.y):
		for x in range(InventoryManager.GRID_SIZE.x):
			var s: InventorySlot = slot_scene.instantiate()
			s.grid_pos = Vector2i(x, y)
			s.position = Vector2(x, y) * CELL_SIZE
			add_child(s)
			slots.append(s)
			
			
