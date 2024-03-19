extends Area2D
export (int) var Areato = 1







func _ready():
	pass






func _on_ChangeArena_body_entered(body):
	M.area = Areato
	pass
