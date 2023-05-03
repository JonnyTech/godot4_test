extends Node

# https://github.com/2shady4u/godot-sqlite

var db : SQLite = null
var db_name := "res://db_scores"
var table_name := "users"
const verbosity_level : int = SQLite.NORMAL

func _ready():
	randomize()
	
func create_db():
	var table_dict : Dictionary = Dictionary()
	table_dict["ID"] = {"data_type":"int", "primary_key": true, "not_null": true}
	table_dict["FirstName"] = {"data_type":"char(40)", "not_null": true}
	table_dict["LastName"] = {"data_type":"char(40)", "not_null": true}
	table_dict["Email"] = {"data_type":"char(40)", "not_null": true}
	table_dict["Phone"] = {"data_type":"char(40)", "not_null": true}
	table_dict["Nationality"] = {"data_type":"char(40)", "not_null": true}
	table_dict["Gender"] = {"data_type":"char(40)", "not_null": true}
	table_dict["Score"] = {"data_type":"int", "not_null": true}
	db = SQLite.new()
	db.path = db_name
	db.verbosity_level = verbosity_level
	db.open_db()
	db.drop_table(table_name)
	db.create_table(table_name,table_dict)
	db.close_db()

func populate_db():
	var characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
	var rnd_str = func(maxlen: int):
		var result = ""
		for i in range(randi() % maxlen + 1):
			result += characters[randi() % characters.length()]
		return result
	var row_array : Array = []
	for i in 100:
		row_array.append({"FirstName":rnd_str.call(10),"LastName":rnd_str.call(10),"Email":rnd_str.call(6)+"@"+rnd_str.call(10),"Phone":str(randi() % 10000000),"Nationality":rnd_str.call(15),"Gender":rnd_str.call(1),"Score":randi() % 100000})
	db = SQLite.new()
	db.path = db_name
	db.verbosity_level = verbosity_level
	db.open_db()
	db.insert_rows(table_name, row_array)
	db.close_db()

func read_db():
	db = SQLite.new()
	db.path = db_name
	db.verbosity_level = verbosity_level
	db.read_only = true
	db.open_db()
	db.query("SELECT FirstName, LastName, Score FROM " + table_name + " ORDER BY score DESC LIMIT 5;")
	var query_result : Array = db.query_result
	var label := $"../lbl_db_read"
	label.text = ""
	if query_result.is_empty():
		label.text = "EMPTY DATABASE"
	else:
		for selected_row in query_result:
			label.text = label.text + "\n" + str(selected_row)
	db.close_db()
