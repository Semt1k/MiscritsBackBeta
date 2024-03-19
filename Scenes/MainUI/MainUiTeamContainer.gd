extends TextureRect








func _ready():
	M.MainUiTeamContainer = self
	pass

func Update_Team():
	for vis in $HBoxContainer.get_children():
		vis.visible = false
	for id in M.UR_TEAM.size():
		var sid = M.UR_TEAM[id]
		var data = M.UR_MISCRITS[sid]
		var node = $HBoxContainer.get_child(id)
		node.visible = true
		
		node.update_icon(data)
		
	pass




func _on_Train_pressed():
	M.Main_Ui.get_node("Train").visible = true
	M.stop_player()
	pass


func _on_Team_pressed():
	M.Main_Ui.get_node("Team").visible = true
	M.stop_player()
	pass
