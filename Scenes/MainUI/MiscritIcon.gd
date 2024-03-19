extends TextureRect








func _ready():
	pass

func update_icon(array_data):
	var letter = M.get_evolution(array_data)
	texture = load("res://Assets/Miscrits/Icons/" + str(array_data["Id"]) + letter + ".png")
	get_node("LevelBg/Level").text = str(array_data["Level"])
	
	$Rarity.frame = M.Rare_to_int[M.Miscrits_Data[array_data["Id"]]["Rarity"]]



