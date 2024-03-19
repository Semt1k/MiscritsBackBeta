extends ColorRect
onready var TeamSprite = $Sprite
onready var TeamAnimation = $AnimationPlayer

func update_bg(id):
	
	
	TeamSprite.texture = null
	$Sprite.texture = load("res://Assets/Miscrits/Miscrits/" + str(id) + "a.png")
	
	
		
	TeamSprite.scale = Vector2(0, 0)
	TeamAnimation.play("Spawn")
	yield (TeamAnimation, "animation_finished")
	TeamAnimation.play("Breath")

	
	
	
		
