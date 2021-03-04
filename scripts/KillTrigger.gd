extends Node2D


func _ready():
	pass


func _on_body_entered(body):
	Global.Player.pain()
