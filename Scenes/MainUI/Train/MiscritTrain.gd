extends TextureButton
var id = null







func _ready():
	pass







func _on_EvolitTrain_pressed():
	M.Train.Update(id, false)
	texture_normal = load("res://Assets/Ui/TrainingMiscrit_Selced.png")
	pass
