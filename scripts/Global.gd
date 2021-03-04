extends Node

const UP = Vector2(0,-1)
const DOWN = Vector2(0,1)
const LEFT = Vector2(-1,0)
const RIGHT = Vector2(1,0)

var Player
var GlueGet
var speedSecret
var highJumpSecret

var newGamePlus = false

var pauseMenuActive = false

var freeze = false

var lastCheckpoint = Vector2(0,0)

var lifeCount
var maxLives = 3

var GUI
var CurrentLevel
var CurrentLevelDir
var nextLevel

var music_mute
var volume = -24
var sound_volume = -24
var music_volume = -10

var MainMenu = "res://scenes/MainMenu.tscn"
var Level1 = "res://scenes/Level1.tscn"
var Level2 = "res://scenes/Level2.tscn"
var Level3 = "res://scenes/Level3.tscn"
var Level4 = "res://scenes/Level4.tscn"
var Level5 = "res://scenes/Level5.tscn"
var ending = "res://scenes/ending.tscn"


var speedrunMode = false
var speedrunTimer = 0

func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),Global.volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"),Global.sound_volume)

func _process(delta):
	mainKeyCheck()

func mainKeyCheck():
	if Input.is_action_just_pressed("ui_restart"):
		get_tree().change_scene(CurrentLevelDir)
	#elif Input.is_action_just_pressed("ui_mute"):
	#	get_tree().change_scene(ending)
	elif Input.is_action_just_pressed("ui_cancel"):
		if CurrentLevelDir != MainMenu:
			pauseFunction()
		

onready var PMENU = preload("res://scenes/PauseMenu.tscn")
var pauseMenu

func pauseFunction():
	if !pauseMenuActive:
		freeze = true
		pauseMenuActive = true
		pauseMenu = PMENU.instance()
		get_tree().get_root().add_child(pauseMenu)
	elif pauseMenuActive:
		freeze = false
		pauseMenuActive = false
		pauseMenu.queue_free()
