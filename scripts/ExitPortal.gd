extends Node2D


func _ready():
	$AnimationPlayer.play("intro")



func exitPortal():
	get_tree().change_scene(Global.nextLevel)


func _on_body_entered(body):
	print(Global.nextLevel)
	if body.get_name() == "SpiderPlayer":
		$AnimationPlayer.play("exit")
