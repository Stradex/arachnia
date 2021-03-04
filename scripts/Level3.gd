extends Node2D


func _ready():
	Global.CurrentLevel = self
	Global.nextLevel = Global.Level4
	Global.CurrentLevelDir = Global.Level3
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
		0:
			pass
		1:
			$Door/AnimationPlayer.play("door_Open")
		2:
			$Door2/AnimationPlayer.play("door_Open")
		3:
			$Door3/AnimationPlayer.play("door_Open")

