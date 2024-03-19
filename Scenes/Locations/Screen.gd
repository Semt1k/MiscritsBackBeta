extends YSort
var globalhover: = false
var history
var pos
var event
var id = []
var newid = 0
var object = []
var searching = false
var initpos
var stoptoggle = false
func _ready():
	M.screen = self
	var timer = Timer.new()
	timer.set_wait_time(0.2)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "repeat_me")
	add_child(timer)
	timer.start()

func repeat_me():
	
	if Input.is_action_pressed("Click"):
		if stoptoggle:
			toggle = false
			stoptoggle = false
		if toggle:
			move(get_local_mouse_position())
		
var toggle = false
func _unhandled_input(_event):
	if _event.is_action_pressed("Click"):
		toggle = true
		move(get_local_mouse_position())
	elif _event.is_action_released("Click"):
		toggle = false
	
		
		
		
func signalmove():
	move(get_local_mouse_position())
func move(position, player = null):
	
	if M.player.locked_screen == false and not M.Train.visible and not M.Team.visible:
		get_parent().get_node("Navigation2D/NavigationPolygonInstance").enabled = false
		get_parent().get_node("Navigation2D/NavigationPolygonInstance").enabled = true
		if player == null:
			position = Vector2(position.x + rand_range( - 5, 5), position.y + rand_range( - 5, 5))
			var path = get_parent().get_node("Navigation2D").get_simple_path($Player.position, position)
			$Line2D.points = path
			$Player.path = path
			$Player.moving = true
		else :
			if searching == false:
				var path = get_parent().get_node("Navigation2D").get_simple_path(player.position, position)
				player.path = path
func moveotherplayer(position, player):
	get_parent().get_node("Navigation2D/NavigationPolygonInstance").enabled = false
	get_parent().get_node("Navigation2D/NavigationPolygonInstance").enabled = true
	var path = get_parent().get_node("Navigation2D").get_simple_path(player.position, position)
	player.path = path
	player.moveme()
func check():
	var dup = get_duplicates(id)
	var inv = object
	inv.invert()
	for i in inv:
		if i.id in dup:
			print(i.name)

func set_id():
	for i in object:
		i.id = newid
		newid += 1

func get_duplicates(a):
	if a.size() < 2:
		return []

	var seen = {}
	seen[a[0]] = true
	var duplicate_indexes = []

	for i in range(1, a.size()):
		var v = a[i]
		if seen.has(v):
			
			duplicate_indexes.append(i)
		else :
			seen[v] = true

	return duplicate_indexes

