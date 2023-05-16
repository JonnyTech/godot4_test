extends OptionButton

func _ready():
	var dir = DirAccess.open("res://flags")
	var files = dir.get_files()
	for file in files:
		if file.ends_with(".svg.import"):
			$".".add_item(dir.get_current_dir().path_join(file.trim_suffix(".import")))
	$".".select(-1)

func _on_item_selected(index):
	$flags.texture = load($".".get_item_text(index))
