extends Node2D


func _ready():
	Global.CurrentLevel = self
	Global.nextLevel = Global.ending
	Global.CurrentLevelDir = Global.Level5
	Global.lifeCount = 3
	
	Global.lastCheckpoint = Global.Player.position
	$exitTile.hide()
	$exitTile.position = Vector2(2000,2000)
	Global.GlueGet = true

var enemyDead = false
func _process(delta):
	if Global.lifeCount < 0:
		gameOver()
	
	if enemyHP == 0 && !enemyDead:
		enemyDead = true
		$exitTile.show()
		$exitTile/AnimationPlayer.play("blockspawn")
		$exitTile.position = Vector2(0,0)
		
	
	if Global.speedrunMode:
		Global.speedrunTimer += delta


func gameOver():
	get_tree().change_scene("res://scenes/GameOver.tscn")

var enemyHP = 4
func switchAction(whichSwitch):
	match whichSwitch:
		1:
			enemyHP -= 1
			$laserShooter.bossHP -= 1
			$laserShooter.setSpeed()
			print(enemyHP)
		2:
			enemyHP -= 1
			$laserShooter.bossHP -= 1
			$laserShooter.setSpeed()
			print(enemyHP)
		3:
			enemyHP -= 1
			$laserShooter.bossHP -= 1
			$laserShooter.setSpeed()
			print(enemyHP)
		4:
			enemyHP -= 1
			$laserShooter.bossHP -= 1
			$laserShooter.setSpeed()
			print(enemyHP)
		0:
			pass


func _on_arenaEnter_body_entered(body):
	$BossCamera.current = true
	$SpiderPlayer/Camera2D.current = false
	Global.lastCheckpoint = Global.Player.position


func _on_arenaExit_body_entered(body):
	$BossCamera.current = false
	$SpiderPlayer/Camera2D.current = true


func _on_exitTrigger_body_entered(body):
	if body.get_name() == "SpiderPlayer":
		get_tree().change_scene(Global.nextLevel)
