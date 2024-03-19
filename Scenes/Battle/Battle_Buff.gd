extends TextureRect
export (String) var type = "ea"
var value_ = 0
var metadata = {}






func _ready():
	$Sprite.texture = load("res://Assets/Battle/Battle_Statuses/StatusIcon" + str(type) + ".png")
	
	pass

func spawn(value):
	value_ += value
	if not visible:
		visible = true
		$Sprite / AnimationPlayer.play("Spawn")
	else :
		$Sprite / AnimationPlayer.play("White")
	if value_ >= 1:
		$Sprite / Arrow.texture = load("res://Assets/Battle/Battle_Statuses/StatusIconArrowUp.png")
	elif value_ <= - 1:
		$Sprite / Arrow.texture = load("res://Assets/Battle/Battle_Statuses/StatusIconArrowDown.png")
	else :
		visible = false
	hint_tooltip = "+" + str(value_)
func spawn_not_def(value):
	$Sprite / Arrow.visible = false
	$Sprite / Count.visible = true
	value_ = value
	$Sprite / Count.text = str(value_)
	if type == "Negate":
		$Sprite / Count.visible = false
	if not visible:
		visible = true
		$Sprite / AnimationPlayer.play("Spawn")
	else :
		$Sprite / AnimationPlayer.play("White")
	
	
	
	
	if value_ == 0:
		$Sprite.scale.y = 0
		visible = false
	hint_tooltip = "+" + str(value)



