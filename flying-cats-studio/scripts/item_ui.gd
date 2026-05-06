extends Control
class_name ItemUI

@onready var icon: TextureRect = $Icon

var item: LootItemInstance
var grid_pos: Vector2i
var dragging := false
var drag_offset := Vector2.ZERO

const CELL_SIZE := 32

func setup(i: LootItemInstance):
	item = i
	if icon:
		icon.texture = item.base.icon
		
	custom_minimum_size = item.base.size * CELL_SIZE
	size = custom_minimum_size
	if icon:
		icon.size = custom_minimum_size
		
func _process(_delta):
	if dragging:
		global_position = get_global_mouse_position() - drag_offset
		
		var grid_ui := get_parent() as InventoryGridUI
		grid_ui.update_drag_preview(
			item,
			grid_ui.get_local_mouse_position()
		)
		
func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			set_z_index(100)
			drag_offset = get_global_mouse_position() - global_position
			InventoryManager.clear_item(item)
		else:
			dragging = false
			set_z_index(0)
			_drop()
		
func _drop():
	var grid_ui := get_parent() as InventoryGridUI
	grid_ui.clear_highlights()
	
	var local := grid_ui.get_local_mouse_position()
	var target := (local / CELL_SIZE).floor()
	
	if InventoryManager.can_place(item, target):
		InventoryManager.place(item, target)
		grid_pos = target
	else:
		InventoryManager.place(item, grid_pos)
		
	position = grid_pos * CELL_SIZE
