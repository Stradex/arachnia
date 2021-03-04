extends Sprite


func _ready():
	pass

func _on_Area2D_body_entered(body):
	if body.get_name() == "SpiderPlayer":
		Global.highJumpSecret = true
		
		Global.freeze = true
		$Timer.start()
		
		Global.GUI.setText2("You got\nHigh Jump\nPress SHIFT to jump higher")
		Global.music_mute = true
		hide()



func _on_Timer_timeout():
	Global.freeze = false
	Global.music_mute = false
	Global.GUI.setText2("")
	queue_free()
