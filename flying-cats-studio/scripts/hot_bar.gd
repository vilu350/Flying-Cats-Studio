extends Control

var current_scene

@onready var ui: CanvasLayer = $"../UI"
@export var inventory : GridContainer
@export var hotbar : HBoxContainer

func _on_hotbar_equip(item: Item) -> void:
	if current_scene != null:
		current_scene.currently_equipped = item

func use_stackable_item():
	hotbar.update()
	hotbar.use_current()
	
func add_item(item : Item, amount : int = 1):
	for slot in hotbar.get_children():
		if slot.item == null:
			slot.item = item
			slot.set_amount(amount)
			return
		elif slot.item == item:
			slot.add_amount(5)
			return
			
	for slot in ui.get_children():
		if slot.item == null:
			slot.item = item
			slot.set_amount(amount)
			return
		elif slot.item == item:
			slot.add_amount(amount)
			return
	print("Full Inventory")
