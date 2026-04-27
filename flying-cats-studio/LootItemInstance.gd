extends Resource
class_name LootItemInstance

@export var base: ItemData
@export var rarity: LootEnums.Rarity

@export var prefixes: Array[AffixData] = []
@export var suffixes: Array[AffixData] = []

var rolled_stats: Dictionary = {}

const RARITY_COLORS := {
	LootEnums.Rarity.COMMON: Color.WHITE,
	LootEnums.Rarity.UNCOMMON: Color("00e11cff"),
	LootEnums.Rarity.Rare: Color("2a1fd7ff"),
	LootEnums.Rarity.LEGENDARY: Color("#ff6a00"),
}

func get_display_name() -> String:
	var n = base.name
