extends Area2D
export  var Name:String
export  var argtoopts:Dictionary

export  var options:Array = ["Bye"]

var panel
var entered

func _ready():
	match Name:
		"Magicite Novice":
			if M.Quests.has(1):
				position = Vector2( - 3557, - 134)
				pass
		"Magicite Neophyte":
			if M.Quests.has(2):
				position = Vector2( - 449, - 86)
		"Magicite Adept":
			if M.Quests.has(3):
				position = Vector2( - 471, - 1738)
	pass
func _on_Body_gui_input(_event):
	if Input.is_action_just_released("Click"):
		M.screen.move(global_position)
			
		
		
func addui():
	pass
func _on_Body_mouse_entered():
	panel = M.panel_scene.instance()
	get_parent().get_parent().get_node("MainUi/Panel").add_child(panel)
	panel.text(Name)
	modulate = Color(1.25, 1.25, 1.25, 1)

func _on_Body_mouse_exited():
	if panel != null:
		panel.queue_free()
	modulate = Color(1, 1, 1, 1)

func _on_Npc_body_entered(body):
	entered = true
	if Name == "Nature Elementum":
		M.initiate_battle(Name, 0)
	else :
		var node = $NPCUI if has_node("NPCUI") else get_node(Name)
		node.name = Name
		
		node.Variants = options
		node.generate(Name)
		
		if not M.Quests.has("1"):
			M.player.path = M.location.get_node("Navigation2D").get_simple_path(M.player.position, $Position2D.global_position)
			
			M.player.moving = true
			M.player.locked_screen = true
		yield (M.player, "moving")
		if entered == true:
			
			pass
			
			
			

func _on_Npc_body_exited(body):
	if body == M.player:
		entered = false
