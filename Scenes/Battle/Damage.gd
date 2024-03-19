extends Label
var small


func _ready():
	
	if small == true:
		$Label.text = text
		text = ""
	$AnimationPlayer.play("Start")
	yield ($AnimationPlayer, "animation_finished")
	queue_free()
