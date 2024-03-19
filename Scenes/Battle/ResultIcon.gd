extends Panel
var type = 0







func _ready():
	if type == 1:
		$XPBar.visible = false
		$HealthBar.rect_position.y = 46
		
	pass





