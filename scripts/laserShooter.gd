extends Node2D


func _ready():
	pass

onready var Laser = preload("res://scenes/hazards/laser.tscn")

var bossHP = 4

func _on_Timer_timeout():
	laserShooter()
	$Timer.start()
	if bossHP < 2:
		laserShooter()
	print("shooty shoot")

func setSpeed():
	if bossHP != 0:
		$Timer.wait_time = bossHP*0.4
	match bossHP:
		3:
			$AnimatedSprite.play("sprite2")
		2:
			$AnimatedSprite.play("sprite3")
			$AnimationPlayer.play("movement")
		1:
			$AnimatedSprite.play("sprite4")
			$AnimationPlayer.play("toCenter")
		0:
			queue_free()


func laserShooter():
	var laser = Laser.instance()
	get_tree().get_root().add_child(laser)
	laser.position = position
	var dir = (Global.Player.position - position).normalized()
	laser.rotation = dir.angle() + PI / 2.0
	laser.direction = dir

