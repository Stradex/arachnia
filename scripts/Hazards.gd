extends Node2D


func _ready():
	pass


func _on_body_entered(body):
	if body.get_name() == "SpiderPlayer":
		if !Global.Player.painActive:
			Global.Player.pain()
