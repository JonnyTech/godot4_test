extends Node

# https://github.com/2shady4u/godot-sqlite

var db : SQLite = null
const verbosity_level : int = SQLite.VERBOSE#NORMAL
var label : Label

func _ready():
	label = $"../lbl_db_status"
	randomize()
	label.text = "Database details:\nFilename: " + settings.db_name + "\nTable: " + settings.db_table
	db = SQLite.new()
	db.verbosity_level = verbosity_level
	db.default_extension = ""
	db.path = settings.db_name

func db_create():
	db.read_only = false
	db.open_db()
	db.drop_table(settings.db_table)
	db.create_table(settings.db_table, {
		"FirstName" : {"data_type":"char(40)", "not_null": true},
		"LastName" : {"data_type":"char(40)", "not_null": true},
		"Email" : {"data_type":"char(40)", "not_null": true},
		"Phone" : {"data_type":"char(40)", "not_null": true},
		"Nationality" : {"data_type":"char(40)", "not_null": true},
		"Gender" : {"data_type":"char(40)", "not_null": true},
		"Score" : {"data_type":"int", "not_null": true}
	})
	db.close_db()
	label.text = "Database created"

func db_insert(data: Dictionary):
	db.open_db()
	db.insert_row(settings.db_table, {"FirstName":data["FirstName"],"LastName":data["LastName"],"Email":data["Email"],"Phone":data["Phone"],"Nationality":data["Nationality"],"Gender":data["Gender"],"Score":int(data["Score"])})
	db.close_db()

func db_fill():
	const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
	var rnd_str = func(maxlen: int):
		var result = ""
		for i in range(randi() % maxlen + 1):
			result += characters[randi() % characters.length()]
		return result
	db.read_only = false
	if not db.open_db():
		label.text = "Error opening database"
		return
	var row_array : Array = []
	for i in 100:
		row_array.append({"FirstName":rnd_str.call(10),"LastName":rnd_str.call(10),"Email":rnd_str.call(6)+"@"+rnd_str.call(10),"Phone":str(randi() % 10000000),"Nationality":rnd_str.call(15),"Gender":rnd_str.call(1),"Score":randi() % 100000})
	if db.insert_rows(settings.db_table, row_array):
		label.text = "Added 100 rows to " + settings.db_table
	else:
		label.text = "Error writing to table: " + settings.db_table
	db.close_db()

func db_read():
	label.text = ""
	if not FileAccess.file_exists(settings.db_name):
		label.text = "Error: database not found"
		return
	else:
		db.read_only = true
		if not db.open_db():
			label.text = "Error opening database"
		else:
			db.query("SELECT FirstName, LastName, Score FROM " + settings.db_table + " ORDER BY score DESC LIMIT 5;")
			var query_result : Array = db.query_result
			if query_result.is_empty():
				label.text = "EMPTY DATABASE"
			else:
				for selected_row in query_result:
					label.text = label.text + str(selected_row) + "\n"
		db.close_db()
