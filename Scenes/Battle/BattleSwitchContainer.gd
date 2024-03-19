extends Panel
var battle_data_ = []
export (bool) var Battle = true
export (bool) var Team = false
var index = - 1






func _ready():
	if not Battle:
		
		if Team:
			$OptionButton.get_popup().add_item("Remove")
		else :
			$OptionButton.get_popup().add_item("Slot 1")
			$OptionButton.get_popup().add_item("Slot 2")
			$OptionButton.get_popup().add_item("Slot 3")
			$OptionButton.get_popup().add_item("Slot 4")
		$OptionButton.visible = true
		$OptionButton.get_popup().connect("id_pressed", self, "_on_item_pressed")
		pass





func Setup(data, battle_data):
	battle_data_ = battle_data
	$IconPanel / Icon.update_icon(data)
	var letter = M.get_evolution(data)
	letter = M.abcd_to_index[letter]
	$Name.text = str(data["Name"] if data["Name"] != "" else M.Miscrits_Data[data["Id"]]["Names"][letter])
	$IconElement / Element.texture = load("res://Assets/Ui/Miscrits/" + str(M.Miscrits_Data[data["Id"]]["Element"]) + "_Type.png")
	if Battle:
		$HealthBar.setup(battle_data["CHP"], M.get_stat("hp", data))
	else :
		
		$HealthBar.setup(data["CHP"], M.get_stat("hp", data))


func _on_click_pressed():
	if Battle:
		if $HealthBar.value >= 1:
			var findID = - 1
			for f in M.battle.YourTeam.size():
				if M.battle.YourTeam[f]["GlobalId"] == battle_data_["GlobalId"] and f != 0:
					
					M.battle.Switch_Miscrit(f, "Self", false)
	else :
		$OptionButton.visible = not $OptionButton.visible
		pass
	pass


func _on_item_pressed(ID):
	var namer = $OptionButton.get_popup().get_item_text(ID)
	if namer != "Remove":
		M.Team.select_slot(index, ID)
	else :
		M.Team.remove_slot(get_parent().get_index())
	pass
