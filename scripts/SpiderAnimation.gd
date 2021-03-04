extends AnimatedSprite

const PLAYER_SCALE = 1

func _ready():
	pass

var jumping
var falling

func update_animation():
	if get_parent().direction == "left":
		scale.x = -PLAYER_SCALE
	elif get_parent().direction == "right":
		scale.x = PLAYER_SCALE
	
	if get_parent().wallcrawl:
		falling = false
		jumping = false
		if $AnimationPlayer.current_animation != "walk":
			$AnimationPlayer.play("walk")
			
	elif jumping && !get_parent().wallcrawl:
		if $AnimationPlayer.current_animation != "jump":
			$AnimationPlayer.play("jump")
		
	elif falling && !get_parent().wallcrawl:
		if $AnimationPlayer.current_animation != "fall":
			$AnimationPlayer.play("fall")
		
	elif get_parent().movement.x && !get_parent().is_on_wall():
		if $AnimationPlayer.current_animation != "walk":
			$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("idle")
