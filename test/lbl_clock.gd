extends Label

func _ready():
	print("hi")
	pass # Replace with function body.

func _process(delta):
	var time = Time.get_time_dict_from_system()
	$".".text = "%02d:%02d:%02d" % [time.hour, time.minute, time.second]
