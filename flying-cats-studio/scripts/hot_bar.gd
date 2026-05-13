extends Panel

@export var item : Item = null:
	set(value):
		item = value
		
		if value == null:
			$Icon.texture = null
			$Amount.text = ""
			return
			
		$Icon.texture = value.icon
		
var amount : int = 0:
	set(value):
		amount = value
		$Amount.text = str(value)
		if amount <= 0:
			item = null
			
func set_amount(value : int):
	amount = value
	
func add_amount(value : int):
	amount += value
	
func _can_drop_data(_at_position, data):
	if "item" in data:
		return is_instance_of(data.item, Item)
	return false
	
func _drop_data(_at_position, data):
	var temp = item
	item = data.item
	data.item = temp
	
	temp = amount
	amount = data.amount
	data.amount = temp
	
func _get_drag_data(_at_position):
	return self
	
	
