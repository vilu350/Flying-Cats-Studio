extends Control
class_name InventoryGridUI

@export var slot_scene: PackedScene
@export var item_scene: PackedScene

const CELL_SIZE := 128

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
			
func spawn_item_ui(item: LootItemInstance, pos: Vector2i):
	var ui := item_scene.instantiate()
	add_child(ui)
	
	ui.setup(item)
	ui.grid_pos = pos
	ui.position = pos * CELL_SIZE
	
func clear_highlights():
	for s in slots:
		s.clear()
		
func _get_slot_at(pos: Vector2i) -> InventorySlot:
	for s in slots:
		if s.grid_pos == pos:
			return s
	return null
	
func _get_slots_for_item(item: LootItemInstance, pos: Vector2i) -> Array[InventorySlot]:
	var result: Array[InventorySlot] = []
	
	for y in range(item.base.size.y):
		for x in range(item.base.size.x):
			var p := pos + Vector2i(x, y)
			var slot := _get_slot_at(p)
			if slot:
				result.append(slot)
				
	return result
	
func update_drag_preview(item: LootItemInstance, mouse_local_pos: Vector2):
	clear_highlights()
	
	var grid_pos := (mouse_local_pos / CELL_SIZE).floor()
	var valid = InventoryManager.can_place(item, grid_pos)
	
	for slot in _get_slots_for_item(item, grid_pos):
		slot.set_valid(valid)
		
