extends Node

# https://github.com/2shady4u/godot-sqlite

var db : SQLite = null
var db_name := "res://db_scores"
var table_name := "users"
const verbosity_level : int = SQLite.NORMAL

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
	populate_db()

func populate_db():
	db = SQLite.new()
	db.path = db_name
	db.verbosity_level = verbosity_level
	db.open_db()
	db.insert_rows(table_name, [
	{"FirstName":"A","LastName":"A","Email":"@","Phone":"111","Nationality":"A","Gender":"A","Score":1},
	{"FirstName":"B","LastName":"B","Email":"@","Phone":"222","Nationality":"B","Gender":"B","Score":2},
	{"FirstName":"C","LastName":"C","Email":"@","Phone":"333","Nationality":"C","Gender":"C","Score":3},
	{"FirstName":"D","LastName":"D","Email":"@","Phone":"444","Nationality":"D","Gender":"D","Score":4},
	{"FirstName":"E","LastName":"E","Email":"@","Phone":"555","Nationality":"E","Gender":"E","Score":5},
	{"FirstName":"F","LastName":"F","Email":"@","Phone":"666","Nationality":"F","Gender":"F","Score":6},
	{"FirstName":"G","LastName":"G","Email":"@","Phone":"777","Nationality":"G","Gender":"G","Score":7},
	{"FirstName":"H","LastName":"H","Email":"@","Phone":"888","Nationality":"H","Gender":"H","Score":8},
	{"FirstName":"I","LastName":"I","Email":"@","Phone":"999","Nationality":"I","Gender":"I","Score":9},
	{"FirstName":"J","LastName":"J","Email":"@","Phone":"000","Nationality":"J","Gender":"J","Score":0}
	])
	db.close_db()

func read_db():
	db = SQLite.new()
	db.path = db_name
	db.verbosity_level = verbosity_level
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
