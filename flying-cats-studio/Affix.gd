extends Resource
class_name AffixData

@export var is_prefix: bool = true
@export var name_format: String

@export var min_value: float = 1
@export var max_value: float = 10

func roll_value() -> float: 
	return randf_range(min_value, max_value)
