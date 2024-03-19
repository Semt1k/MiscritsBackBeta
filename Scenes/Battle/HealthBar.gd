extends ProgressBar
export (bool) var Text_Visible = true






func _ready():
	$Health.visible = Text_Visible
	pass

func setup(chp, mhp):
	max_value = mhp
	chp = clamp(chp, 0, mhp)
	value = chp
	get_node("Health").text = str(chp) + "/" + str(mhp)
	png_upd(chp)
func png_upd(chp):
	if chp == 0:
		$Control / Full.texture = load("res://Assets/Ui/Miscrits/HealthIconEmpty.png")
	
	
		
		
	pass
func update_animate(chp):
	get_node("Health").text = str(chp) + "/" + str(max_value)
	get_node("Tween").interpolate_property(self, "value", value, chp, 0.2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	get_node("Tween").start()
	self_modulate = M.hpcolorpresset(max_value, chp)
	png_upd(chp)
	pass



