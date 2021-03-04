extends Node2D


func _ready():
	print("caganga")

func _on_Area2D_body_entered(body):
	if body.get_name() == "SpiderPlayer":
		Global.Player.pain()
		print("sarlanga")
	
	queue_free()

var direction : Vector2 = Vector2.LEFT # default direction
var speed : float = 100 #put your rocket speed

func _process(delta):
	translate(direction*speed*delta)
