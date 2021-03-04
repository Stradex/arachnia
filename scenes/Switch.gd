extends Node2D


export var triggerNumber = 0

func _ready():
	pass


func _on_body_entered(body):
	if body.get_name() == "SpiderPlayer":
		$Sprite/AnimationPlayer.play("swTrans")
		
		Global.CurrentLevel.switchAction(triggerNumber)
