extends CanvasLayer

var thread = null
var free = true
var previous_scene
var abcd = ["a", "b", "c", "d"]
var train

onready var progress = $Control / Progress
signal loaded
	
func _thread_load(path, data_array):
	var ril = ResourceLoader.load_interactive(path)
	assert (ril)
	var total = ril.get_stage_count()
	
	progress.call_deferred("set_max", total)
	var res = null
	var forest = false
	while true:
		
		
		update_percentage(ril.get_stage())
		yield ($Control / Tween, "tween_completed")
		
		
		var err = ril.poll()
		
		if err == ERR_FILE_EOF:
			
			res = ril.get_resource()
			break
		elif err != OK:
			
			break
	
	if not (path == "res://Scenes/Battle/Battle.tscn" or path == "res://Scenes/Login.tscn" or path == "res://Scenes/Train.tscn"):
		pass
	call_deferred("_thread_done", res, data_array, path)
func Fake_Loading():
	raise()
	$Control / Progress.visible = false
	$Control.visible = true
	get_tree().get_root().set_disable_input(true)
	$AnimationPlayer.play("fadein")
	yield ($AnimationPlayer, "animation_finished")
	yield (get_tree().create_timer(0.25), "timeout")
	$AnimationPlayer.play("fadeout")
	yield ($AnimationPlayer, "animation_finished")
	$Control.visible = false
	get_tree().get_root().set_disable_input(false)
	$Control / Progress.visible = true

func _thread_done(resource, data_array, path):
	
	assert (resource)
	
	
	

	
	update_percentage(100)
	
	var new_scene = resource.instance()
	get_tree().current_scene = null
	
	get_tree().root.add_child(new_scene)
	if path == "res://Scenes/Battle/Battle.tscn":
		new_scene.Data_load(data_array[0])
	get_tree().current_scene = new_scene
	yield (get_tree().create_timer(0.45), "timeout")
	$AnimationPlayer.play("fadeout")
	yield ($AnimationPlayer, "animation_finished")
	yield (get_tree().create_timer(0.1), "timeout")
	$Control.visible = false
	get_tree().get_root().set_disable_input(false)
	if path == "res://Scenes/Battle/Battle.tscn":
		new_scene.Spawn(data_array[0])

func load_scene(path, data_array):
	_thread_load(path, data_array)
	raise()
	$Control.visible = true
	$AnimationPlayer.play("fadein")
	print("playing annn star")
	yield (get_tree(), "idle_frame")

func load_previous_scene():

	get_tree().current_scene.queue_free()
	get_tree().current_scene = null
	previous_scene.visible = true
	previous_scene.get_node("CanvasLayer/Control/").visible = true
	previous_scene.get_node("CanvasLayer/show").visible = false
	previous_scene.get_node("AudioStreamPlayer").playing = true
	get_tree().current_scene = previous_scene

func update_percentage(per):
	$Control / Tween.interpolate_property(progress, "value", progress.value, per, 0.005, Tween.EASE_IN, Tween.EASE_OUT)
	$Control / Tween.start()

