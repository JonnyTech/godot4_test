extends Node

var db_name : String
var db_table : String
var background : String
var udp_port : int
var mouse : bool
var passphrase : String
var settingsfile : String

func _ready():
	var cmdline = OS.get_cmdline_user_args()
	if len(cmdline) > 0:
		db_name = cmdline[0]
	var settingspath : String
	if OS.has_feature("editor"):
		settingsfile = ProjectSettings.globalize_path("res://settings.json");
	else:
		settingspath = OS.get_executable_path().get_base_dir()
		settingsfile = settingspath.path_join("settings.json")
	var txt_settings = FileAccess.open(settingsfile, FileAccess.READ)
	var json_settings = JSON.new()
	if FileAccess.get_open_error() == OK:
		json_settings.parse(txt_settings.get_as_text())
		var data_settings = json_settings.data
		db_table = data_settings["db_table"]
		udp_port = data_settings["udp_port"]
		mouse = data_settings["mouse"]
		passphrase = data_settings["passphrase"]
		if OS.has_feature("editor"):
			if db_name.is_empty():
				db_name = "res://" + data_settings["db_name"]
			background = "res://" + data_settings["background"]
		else:
			if db_name.is_empty():
				db_name = settingspath.path_join(data_settings["db_name"])
			background = settingspath.path_join(data_settings["background"])
