extends VideoStreamPlayer

func _ready():
	var vsp = VideoStreamTheora.new()
	vsp.file = settings.background
	self.stream = vsp
	self.play()
