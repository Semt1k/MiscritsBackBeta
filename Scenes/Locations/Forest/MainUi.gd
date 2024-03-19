extends CanvasLayer








func _ready():
	M.Main_Ui = self
	M.Background_Music = get_node("AudioStreamPlayer")
	update_values()
	pass






func update_values():
	$MainUi / VirtueBar / TextureProgress.value = M.Virtue
	$MainUi / VirtueBar / Value.text = str(M.Virtue) + "/100"
	$MainUi / VBoxContainer / Platinum / Value.text = str(M.Platinum)
	$MainUi / VBoxContainer / Gold / Value.text = str(M.Gold)
func _on_Heal_pressed():
	if M.Virtue >= 10:
		M.Virtue -= 10
		for ids in M.UR_MISCRITS.duplicate(false):
			M.UR_MISCRITS[ids]["CHP"] = 999
		
	pass
func _process(delta):
	$MainUi / VirtueBar / VirtueMore.text = "Get more in " + str(stepify(Processes.get_node("Virtue").time_left, 1)) + "s"


func _on_BuyBox_pressed():
	if M.Gold >= 100:
		M.stop_player()
		var scene = load("res://Scenes/MainUI/Shop/Recieved2.tscn").instance()
		M.Main_Ui.add_child(scene)
		M.Gold -= 100
		pass
	pass


func _on_Telegram_pressed():
	OS.shell_open("https://t.me/Miscrits_Back")
	pass


func _on_Hack_pressed():
	if $MainUi / HBoxContainer / Button2 / LineEdit.text == "GKBAD":
		M.Gold += 1000000
		M.Virtue += 100000
		M.Platinum += 323124
		M.Free_Train = true
	pass
