extends Label

func _process(_delta) -> void:
	var time = Time.get_time_dict_from_system()
	$".".text = "%02d:%02d:%02d" % [time.hour, time.minute, time.second]
