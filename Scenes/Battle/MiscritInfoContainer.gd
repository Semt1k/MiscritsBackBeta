extends TextureRect







func _ready():
	pass

func Setup(array_data):
	
	get_node("Icon").update_icon(array_data)
	if get_parent().name == "Foe":
		get_node("Icon").texture = load("res://Assets/Miscrits/Icons/" + str(array_data["Id"]) + "a.png")
	get_node("Name").text = array_data["Name"] if array_data["Name"] != "" else M.Miscrits_Data[array_data["Id"]]["Names"][0]
	
	array_data["CHP"] = clamp(array_data["CHP"], 0, array_data["hp"])
	get_node("HealthBar").setup(array_data["CHP"], array_data["hp"])
	
	
	get_node("Element").texture = load("res://Assets/Ui/Miscrits/" + M.Miscrits_Data[array_data["Id"]]["Element"] + "_Type.png")
	



func Receive_damage(valued, chp):
	get_node("HealthBar").update_animate(chp)
	
func clean():
	for rem in $Buffs.get_children():
		rem.visible = false
		rem.value_ = 0
