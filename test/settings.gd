extends Node

var db_name : String
var db_table : String
var background : String

func _ready():
	var txt_settings = FileAccess.open("res://settings.json", FileAccess.READ)
	var json_settings = JSON.new()
	if FileAccess.get_open_error() == OK:
		json_settings.parse(txt_settings.get_as_text())
		var data_settings = json_settings.data
		db_name = "res://" + data_settings["db_name"]
		db_table = data_settings["db_table"]
		background = "res://" + data_settings["background"]