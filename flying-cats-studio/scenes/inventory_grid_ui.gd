extends Control
class_name InventoryGridUI

@export var slot_scene: PackedScene
@export var item_scene: PackedScene

const CELL_SIZE := 32

var slots: Array[InventorySlot] = []
