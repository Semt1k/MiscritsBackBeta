extends Area2D
export (int) var id
var search
var hover
var enter
var click = false
var panelinstance = M.panel_scene
var panel
var color

var timeremaining


var _timer = null
var repeat_timer = null

func _ready():
	visible = false
	
	
	set_process_unhandled_input(true)
	search = false
	_timer = Timer.new()
	add_child(_timer)
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(1.0)
	_timer.set_one_shot(false)
	
	
	
	
	
	

func _on_Timer_timeout():
	
	
	pass
	
func repeat():
	
	
	
		
	
	pass
var entercode = - 1
func _on_Area2D_body_entered(body):
	if M.Clicked_Object == self:
		get_tree().get_root().set_disable_input(true)
		yield (get_tree().create_timer(0.1), "timeout")
		
		var searching = load("res://Scenes/Locations/Searching.tscn").instance()
		M.player.add_child(searching)
		yield (M.player.get_node("Searching").get_child(2), "animation_finished")
		
		M.initiate_battle("Area " + str(M.area), id)
		M.Background_Music.playing = false
		if is_instance_valid(panel):
			panel.queue_free()
		yield (get_tree().create_timer(1), "timeout")
		get_tree().get_root().set_disable_input(false)
	
		
		
		
	
	
		
		
	pass
func close_repeat():
	pass

	

	
func start_repeat():
	repeat_timer = Timer.new()
	repeat_timer.set_one_shot(false)
	repeat_timer.set_wait_time(0.2)
	add_child(repeat_timer)
	repeat_timer.connect("timeout", self, "repeat")
	repeat_timer.start()

func _on_Area2D_body_exited(body):
	pass
	
		
		
		

func _on_StaticBody2D_mouse_entered():
	
		
	if get_parent().name == "Searchable":
		panel = panelinstance.instance()
		get_parent().get_parent().get_parent().get_node("MainUi/Panel").add_child(panel)
		
		
		
			
			
			
		
		panel.text("Search for Miscrit")
		modulate = Color(1.25, 1.25, 1.25, 1)
	









func _on_StaticBody2D_mouse_exited():
	if get_parent().get_parent().globalhover != false:
		if get_parent().get_parent().history == self:
			get_parent().get_parent().history = null
		if get_parent().get_parent().history != null:
			self._on_StaticBody2D_mouse_entered()
	get_parent().get_parent().globalhover = false
	hover = false
	if is_instance_valid(panel):
		panel.queue_free()
	modulate = Color(1, 1, 1, 1)
	_timer.stop()

func _on_StaticBody2D_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_released("Click"):
		M.Clicked_Object = self
		click = true
		get_parent().get_parent().move(Vector2(global_position.x, global_position.y + 15))
		var wait: = Timer.new()
		wait.set_wait_time(3.0)
		add_child(wait)
		wait.start()
		yield (wait, "timeout")
		wait.queue_free()
		click = false


func _on_VisibilityNotifier2D_screen_entered():
	
	visible = true
	pass


func _on_VisibilityNotifier2D_screen_exited():
	visible = false
	pass
