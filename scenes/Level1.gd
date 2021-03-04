extends Node2D


func _ready():
	Global.CurrentLevel = self
	Global.nextLevel = Global.Level2
	Global.CurrentLevelDir = Global.Level1
	Global.lifeCount = 3
	
	Global.lastCheckpoint = Global.Player.position


func _process(delta):
	if Global.lifeCount < 0:
		gameOver()
	
	elif Global.speedrunMode:
		Global.speedrunTimer += delta

func gameOver():
	get_tree().change_scene("res://scenes/GameOver.tscn")

func _on_Area2D_body_entered(body):
	Global.Player.pain()

func switchAction(whichSwitch):
	match whichSwitch:
		1:
			$Doors/Door1/AnimationPlayer.play("door_Open")
		2:
			$Doors/Door2/AnimationPlayer.play("door_Open")
		0:
			pass

