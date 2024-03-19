extends Control








func _ready():
	M.Team = self
	pass





var stroke = 0
var local_ur_team = []
func _on_Team_visibility_changed():
	if visible:
		stroke = 0
		$AnimationPlayer.play("Spawn")
		local_ur_team = M.UR_TEAM.duplicate(true)
		Update()
	pass
func Update():
	$Team / OtherLess.disabled = true
	$Team / OtherMore.disabled = stroke == 0
	print(local_ur_team, "local")
	for rem in $Team / Other.get_children():
		$Team / Other.remove_child(rem)
		rem.queue_free()
	for index in local_ur_team.size():
		var node = $Team / Team.get_child(index)
		var dict = M.UR_MISCRITS[local_ur_team[index]]
		node.get_node("BattleSwitchContainer").Setup(dict, [])
		node.get_node("BattleSwitchContainer").visible = true
		node.get_node("TextureRect").visible = true
		var letter = M.get_evolution(dict)
		node.get_node("TextureRect").texture = load("res://Assets/Miscrits/Miscrits/" + dict["Id"] + letter + ".png")
		node.get_node("Add").visible = false
	var childs = $Team / Team.get_children()
	childs.invert()
	for index in 4 - local_ur_team.size():
		
		
		var ch = childs[index]
		ch.get_node("TextureRect").visible = false
		ch.get_node("Add").visible = true
		ch.get_node("BattleSwitchContainer").visible = false
	var array_other_evos = M.UR_MISCRITS.keys().duplicate(true)
	array_other_evos.sort_custom(M.MyCustomSorter, "sort_ascending")
	for rem in local_ur_team:
		array_other_evos.erase(rem)
	for pop in stroke * 12:
		array_other_evos.pop_front()
		
	while array_other_evos.size() >= 13:
		array_other_evos.pop_back()
		$Team / OtherLess.disabled = false
	for spawn in array_other_evos:
		var ins = load("res://Scenes/Battle/BattleSwitchContainer.tscn").instance()
		ins.Battle = false
		ins.Setup(M.UR_MISCRITS[spawn], [])
		ins.index = spawn
		$Team / Other.add_child(ins)
	while $Team / Other.get_child_count() != 12:
		var ins = load("res://Scenes/MainUI/Team/CaptureMoreTeam.tscn").instance()
		$Team / Other.add_child(ins)
func remove_slot(ID):
	if not local_ur_team.size() == 1:
		local_ur_team.remove(ID)
		Update()
func select_slot(id, slot):
	if local_ur_team.size() < 4:
		if local_ur_team.size() > slot:
			local_ur_team[slot] = id
		else :
			local_ur_team.append(id)
	
	else :
		
		local_ur_team[slot] = id
		
	Update()
func _on_Close_pressed():
	visible = false
	M.UR_TEAM = local_ur_team.duplicate(true)
	M.MainUiTeamContainer.Update_Team()
	pass


func _on_OtherMore_pressed():
	stroke -= 1
	Update()
	pass


func _on_OtherLess_pressed():
	stroke += 1
	Update()
	pass
