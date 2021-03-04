extends KinematicBody2D

const H_SPEED = 52
const MAX_FALL_SPEED = 1250
const GRAVITY = 512
const JUMP_SPEED = -144
const MIN_JUMP_HEIGHT = -32

var movement = Vector2(0,0)
var direction = ""

var speedModifier = 1
var fallModifier = 1
var highJumpModifier = 1

var wallcrawl = false
var painActive = false

func _ready():
	Global.Player = self


func _physics_process(delta):
	if !Global.freeze:
		physics_control(delta)
	
	debugText()
	
	speedCheck()
	$SpiderSprite.update_animation()
	

func speedCheck():
	if Global.speedSecret:
		if Input.is_action_pressed("ui_speed"):
			speedModifier = 1.5
		else: 
			speedModifier = 1
	if Global.highJumpSecret:
		if Input.is_action_pressed("ui_speed"):
			highJumpModifier = 1.8
		else: 
			highJumpModifier = 1

func physics_control(delta):
	
	fall(delta)
	hmove()
	jump()
	
	walldetection()
	
	move_and_slide(movement,Global.UP)

func hmove():
	if Input.is_action_pressed("ui_left"):
		movement.x = -H_SPEED * speedModifier
		direction = "left"
		if !$sfx_steps.playing && is_on_floor():
			$sfx_steps.play()
	elif Input.is_action_pressed("ui_right"):
		movement.x = H_SPEED * speedModifier
		direction = "right"
		if !$sfx_steps.playing && is_on_floor():
			$sfx_steps.play()
	else:
		movement.x = 0
		direction = "none"
		$sfx_steps.stop()

func fall(delta):
	if wallcrawl:
		movement.y = 0
	
	elif is_on_floor():
		movement.y = 0
		$SpiderSprite.jumping = false
		$SpiderSprite.falling = false
		
	elif is_on_ceiling():
		movement.y = 1 * fallModifier
		$SpiderSprite.falling = true
		
	else:
		if movement.y > MAX_FALL_SPEED:
			movement.y = MAX_FALL_SPEED
			movement.y *= fallModifier
			$SpiderSprite.falling = true
		else:
			movement.y += GRAVITY * delta
			movement.y *= fallModifier
		if movement.y > 25:
			$SpiderSprite.falling = true
			$SpiderSprite.jumping = false

func jump():
	if Input.is_action_pressed("ui_up") && is_on_floor():
		movement.y = JUMP_SPEED * highJumpModifier
		
		$SpiderSprite.jumping = true
		$sfx_jump.play()
		$sfx_steps.stop()
	if Input.is_action_just_released("ui_up") && movement.y < MIN_JUMP_HEIGHT:
		movement.y = MIN_JUMP_HEIGHT

	
	#elif Input.is_action_just_released("ui_up"):
		#movement.y = 0


func walldetection():
	if Global.GlueGet:
		#if Input.is_action_pressed("key_crawl"):
		if is_on_wall() && Input.is_action_pressed("ui_left"):
			
			fallModifier = 0
			$SpiderSprite.rotation_degrees = 90
			
			if Input.is_action_pressed("ui_up"):
				movement.y = -H_SPEED * speedModifier
				wallcrawl = true
			elif Input.is_action_pressed("ui_down"):
				movement.y = H_SPEED * speedModifier
				wallcrawl = true
			else:
				wallcrawl = false
		
		elif is_on_wall() && Input.is_action_pressed("ui_right"):
			$SpiderSprite.rotation_degrees = -90
			fallModifier = 0
			
			if Input.is_action_pressed("ui_up"):
				movement.y = -H_SPEED * speedModifier
				wallcrawl = true
			elif Input.is_action_pressed("ui_down"):
				movement.y = H_SPEED * speedModifier
				wallcrawl = true
			else:
				wallcrawl = false
		
		else:
			$SpiderSprite.rotation_degrees = 0
			fallModifier = 1
			wallcrawl = false
	





func pain():
	painActive = true
	position = Global.lastCheckpoint
	movement.y = JUMP_SPEED*0.5
	Global.lifeCount -= 1
	
	$sfx_pain.play()
	$DebuffAnimations.play("pain")
	

func unpain():
	painActive = false





func debugText():
	#$debugtext.text = str(painActive)
	
	pass
