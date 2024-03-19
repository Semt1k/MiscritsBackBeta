extends Node








func _ready():
	pass







func _on_Virtue_timeout():
	M.Virtue = clamp(M.Virtue + 1, 0, 100)
	pass


func _on_Save_timeout():
	M.Save()
	pass
