extends Node2D


func _ready():
	pass

func _process(delta):
	if Global.music_mute:
		$AudioStreamPlayer.volume_db = -80
	else:
		$AudioStreamPlayer.volume_db = Global.music_volume
