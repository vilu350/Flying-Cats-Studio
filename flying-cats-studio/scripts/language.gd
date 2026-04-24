extends VBoxContainer

@export var language_option: OptionButton

var languages := {
	"English": "en", 
	"Spanish (n/a)": "es",
	"French (n/a)": "fr",
	"Chinese (n/a)": "cn",
	"Japanese (n/a)": "jp"
}

func _ready():
	for lang_name in languages.keys():
		language_option.add_item(lang_name)
		
	var currect_locale := TranslationServer.get_locale()
	for i in range(language_option.item_count):
		var lang_name := language_option.get_item_text(i)
		if currect_locale.begins_with(languages[lang_name]): 
			language_option.select(i)
			break
	
	language_option.item_selected.connect(_on_language_selected)

func _on_language_selected(index: int):
	var lang_name := language_option.get_item_text(index)
	var locale = languages[lang_name]
	TranslationServer.set_locale(locale)
	print("Locale set to:", locale)
