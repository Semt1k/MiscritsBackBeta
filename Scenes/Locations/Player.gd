extends KinematicBody2D

var path: = PoolVector2Array()
var move_direction
var moving = false
var movable = true
var hover
var side = "back"
var flip = false

var panel
var player_state = {}
var locked_screen = false
signal moving

var skin
var hair
var haircolor
var cloth
var gender
var tier
var emoji = null
var speed = 300.0
var playeruientered = false

func _ready():
	M.player = self
	position = M.SelfPlayerPosition
	
			

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	if flip == true:
		get_node("Sprite").set_scale(Vector2( - 1, 1))
	$"%Camera2D".current = true
func pathtopos():
	if path is PoolVector2Array:
		for n in path.size():
			path[n] = position
var moving_time = 0
var stop_time = 0
func _physics_process(delta):
	
	var distance_to_walk = speed * delta
	if distance_to_walk > 0 and path.size() > 0:
		moving_time += 1
		stop_time = 0
		var distance_to_next_point = position.distance_to(path[0])
		if distance_to_walk <= distance_to_next_point:
			
			
			
			position += position.direction_to(path[0]) * distance_to_walk
			
			move_direction = rad2deg(path[0].angle_to_point(position))
			if move_direction > - 90 and move_direction < 90:
				get_node("Sprite").set_scale(Vector2(1, 1))
				flip = false
			else :
				get_node("Sprite").set_scale(Vector2( - 1, 1))
				flip = true
			if move_direction > 0 and move_direction < 180:
				side = "front"
			else :
				side = "back"
			get_node("AnimationPlayer").play("run" + side)
		else :
			position = path[0]
			path.remove(0)
		distance_to_walk -= distance_to_next_point
	else :
		moving_time = 0
		stop_time += 1
		moving = false
		emit_signal("moving")
		get_node("AnimationPlayer").play("idle" + side)
	
	


func set_player_position(_position):
	set_position(_position)
	
func error(text, color = "da4a4a"):
	$Error.modulate = color
	$Error.text = text
	$Error / AnimationPlayer.play("fade")


func _on_Player_mouse_entered():
	return 
	get_parent().history = self
	
	get_parent().get_parent().get_node("MainUi/Panel").add_child(panel)
	modulate = Color(1.25, 1.25, 1.25, 1)


func _on_Player_mouse_exited():
	if get_parent().globalhover != false:
		if get_parent().history == self:
			get_parent().history = null
		if get_parent().history != null:
			self._on_Player_mouse_entered()
	get_parent().globalhover = false
	hover = false
	if panel != null and is_instance_valid(panel):
		panel.queue_free()
	modulate = Color(1, 1, 1, 1)

func _on_Body_gui_input():
	pass
	

func play_emote(image, id):
	if $Emote / AnimationPlayer.is_playing() == false:
		emoji = id
		$Emote / Emoji.texture = image
		$Emote / AnimationPlayer.play("Popup")
		yield ($Emote / AnimationPlayer, "animation_finished")
		$Emote / AnimationPlayer.play("loop")
		yield (get_tree().create_timer(5), "timeout")
		$Emote / AnimationPlayer.play("Pop")
		yield ($Emote / AnimationPlayer, "animation_finished")
		emoji = null

func heal():
	$CPUParticles2D.emitting = true
	yield (get_tree().create_timer(2), "timeout")
	$CPUParticles2D.emitting = false





func _on_MainUI_timeout():
	if M.Main_Ui.get_node("MainUi").modulate == Color(1, 1, 1, 1):
		if moving_time >= 45 and stop_time == 0:
			if not M.Main_Ui.get_node("MainUi/AnimationPlayer").is_playing():
				M.Main_Ui.get_node("MainUi/AnimationPlayer").play("visible_change")
	else :
		if stop_time >= 30 and moving_time == 0:
			if not M.Main_Ui.get_node("MainUi/AnimationPlayer").is_playing():
				M.Main_Ui.get_node("MainUi/AnimationPlayer").play_backwards("visible_change")
	pass
