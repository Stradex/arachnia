extends Node2D

func _ready():
	Global.CurrentLevel = self
	Global.CurrentLevelDir = Global.ending
	
	if Global.speedrunMode:
		$SpeedrunTimer.show()
		$SpeedrunTimer/Time.text = str(int(Global.speedrunTimer/60)) + "mins " + str(int(Global.speedrunTimer)-(60*int(Global.speedrunTimer/60))) + "secs"
	else:
		$SpeedrunTimer.hide()


func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		Global.newGamePlus = true
		get_tree().change_scene(Global.MainMenu)
