extends Node2D


func _ready():
	pass




func _on_body_entered(body):
	if body.get_name() == "SpiderPlayer":
		if Global.lastCheckpoint != position:
			Global.lastCheckpoint = position
			$sfx_save.play()
			$AnimationPlayer.play("checkpointAction") 


func GUItextSet(which):
	match which:
		0:
			Global.GUI.setText("")
		1:
			Global.GUI.setText("CHECKPOINT SET")
