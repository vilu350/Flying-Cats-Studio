extends Node

@export var rarity_table: RarityTable
@export var prefixes: Array[AffixData]
@export var suffixes: Array[AffixData]

func generate_loot(drop_table: ItemDropTable):
	var base_item := drop_table.roll_item()
	if base_item == null:
		return null
		
	var rarity := rarity_table.roll_rarity()
	var loot := LootItemInstance.new()
	loot.base = base_item
	loot.rarity = rarity
	
	match rarity:
		LootEnums.Rarity.COMMON:
			pass
		
		LootEnums.Rarity.UNCOMMON:
			var p = _rand_prefix()
			if p:
				loot.prefixes.append(p)
			#loot.prefixes.append(_rand_prefix())
			
		LootEnums.Rarity.RARE:
			var p = _rand_prefix()
			if p:
				loot.prefixes.append(p)
				
			var s = _rand_suffix()
			if s:
				loot.suffixes.append(s)
			#loot.prefixes.append(_rand_prefix())
			#loot.suffixes.append(_rand_suffix())
			
		LootEnums.Rarity.LEGENDARY:
			var p = _rand_prefix()
			if p:
				loot.prefixes.append(p)
				
			var s = _rand_suffix()
			if s:
				loot.suffixes.append(s)
			#loot.prefixes.append(_rand_prefix())
			#loot.suffixes.append(_rand_suffix())
	
	_roll_affix_values(loot)
	
	return loot
	
	
	
#func _rand_prefix() -> AffixData:
	#return prefixes.is_empty() if null else prefixes.pick_random()
	
#func _rand_suffix() -> AffixData:
	#return suffixes.is_empty() if null else suffixes.pick_random()
	
func _rand_prefix() -> AffixData:
	if prefixes.is_empty():
		return null
	
	return prefixes.pick_random()
	
func _rand_suffix() -> AffixData:
	if suffixes.is_empty():
		return null
		
	return suffixes.pick_random()
	
func _roll_affix_values(loot: LootItemInstance):
	for a in loot.prefixes:
		if a:
			loot.rolled_stats[a] = a.roll_value()
		
	for a in loot.suffixes:
		if a:
			loot.rolled_stats[a] = a.roll_value()
		
		
