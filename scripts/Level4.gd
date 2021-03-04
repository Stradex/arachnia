extends Node2D


func _ready():
	Global.CurrentLevel = self
	Global.nextLevel = Global.Level5
	Global.CurrentLevelDir = Global.Level4
	Global.lifeCount = 3
	
	Global.lastCheckpoint = Global.Player.position


func _process(delta):
	if Global.lifeCount < 0:
		gameOver()
	
	elif Global.speedrunMode:
		Global.speedrunTimer += delta

func gameOver():
	get_tree().change_scene("res://scenes/GameOver.tscn")

func switchAction(whichSwitch):
	match whichSwitch:
		1:
			$Doors/Door1/AnimationPlayer.play("door_Open")
		2:
			$Doors/Door2/AnimationPlayer.play("door_Open")
			$Doors/Door3/AnimationPlayer.play("door_Open")
		0:
			pass



func _on_music_trigger2_body_entered(body):
	if body.get_name() == "SpiderPlayer":
		$music_trigger1.queue_free()
		Global.music_volume -= 3


func _on_music_trigger1_body_entered(body):
	if body.get_name() == "SpiderPlayer":
		$music_trigger2.queue_free()
		Global.music_volume -= 15


func _on_music_trigger3_body_entered(body):
	if body.get_name() == "SpiderPlayer":
		Global.music_volume -= 30
		$music_trigger3.queue_free()
