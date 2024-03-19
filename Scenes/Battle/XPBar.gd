extends ProgressBar
export (bool) var Text_Visible = true
var maxx = false
var exp_visible = true






func _ready():
	if not maxx and exp_visible:
		$Exp.visible = Text_Visible
	pass

func setup(chp, mhp):
	if not maxx:
		max_value = mhp
		chp = clamp(chp, 0, mhp)
		value = chp
		get_node("Exp").text = str(chp) + "/" + str(mhp)
		if chp == mhp:
			exp_visible = false
			self_modulate = Color(1, 0.913725, 0)
		$Exp.visible = chp != mhp
		$Train.visible = chp == mhp
	else :
		value = 0
		$Exp.visible = false
		$Max.visible = true
		$Train.visible = false

	
		
		
	pass
func _process(delta):
	if not maxx and exp_visible:
		$Exp.text = str(int(value)) + "/" + str(max_value)
func Animation_Tween(chp, add, maxximal):
	if not maxx:
		var result = clamp(chp + add, 0, maxximal)
		yield (get_tree().create_timer(1), "timeout")
		get_node("Exp").text = str(result) + "/" + str(maxximal)
		get_node("Tween").interpolate_property(self, "value", chp, result, 0.8, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		
		get_node("Tween").start()
		yield (get_node("Tween"), "tween_completed")
		if result == maxximal:
			$AnimationPlayer.play("NewLvl")



