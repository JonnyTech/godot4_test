extends VideoStreamPlayer

func _ready() -> void:
	var vsp = VideoStreamTheora.new()
	vsp.file = settings.background
	self.stream = vsp
	self.play()
