extends ColorRect
onready var TeamSprite = get_node("Sprite")
export (bool) var flip = false







func _ready():
	$Sprite.flip_h = flip
	pass
func _process(delta):
	if TeamSprite.texture != null:
		TeamSprite.position.x = rect_size.x / 2 - (TeamSprite.texture.get_size().x * TeamSprite.scale.x) / 2
		TeamSprite.position.y = rect_size.y - TeamSprite.texture.get_size().y * TeamSprite.scale.y




