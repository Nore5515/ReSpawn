extends KinematicBody2D


var vel = Vector2()
var gravity = 400
var speed = 65
var jump = -100
var jumping = false
var resetJump = false
var maxJumpBoost = 135
var jumpBoost = maxJumpBoost
var jumpDecay = 3

var canJump = true
var coyTimeRunning = false

var numbers = {
	"0": load("res://Images/0.png"),
	"1": load("res://Images/1.png"),
	"2": load("res://Images/2.png"),
	"3": load("res://Images/3.png"),
	"4": load("res://Images/4.png"),
	"5": load("res://Images/5.png"),
	"6": load("res://Images/6.png"),
	"7": load("res://Images/7.png"),
	"8": load("res://Images/8.png"),
	"9": load("res://Images/9.png")
}

const FLOOR_NORMAL = Vector2.UP

onready var allPoints = get_tree().get_nodes_in_group("checkpoints")
var currentCheckpoint

var corpses = []
var corpse = load("res://Scenes/Corpse.tscn")
var dying = false
var inCheckpoint = false

var totalDeaths = 0

# TESTING
var maxJumpReached = 10000
var currentY = 0

func _ready():
	self.get_node("DeathCounter").visible = false
	

func updateCheckpoint():
	for point in allPoints:
		if point.current:
			currentCheckpoint = point


func updateDeaths():
	self.get_node("DeathCounter").visible = true
	if totalDeaths < 10:
		self.get_node("DeathCounter").get_node("Singles").texture = numbers[String(totalDeaths)]
	else:
		self.get_node("DeathCounter").get_node("Singles").texture = numbers[String(totalDeaths)[1]]
		self.get_node("DeathCounter").get_node("Tens").texture = numbers[String(totalDeaths)[0]]
	
	yield(get_tree().create_timer(0.5), "timeout")
	self.get_node("DeathCounter").visible = false
	

func death():
	if currentCheckpoint != null && !inCheckpoint:
		self.get_node("DeadSound").play()
		
		totalDeaths += 1
		var body = corpse.instance()
		body.set_name("Corpse")
		body.position = self.position
		self.get_parent().add_child(body)
		
		corpses.append(body)
		
		self.position = currentCheckpoint.position
		vel = Vector2()
		updateDeaths()
	elif inCheckpoint:
		self.get_node("NoCorpseDeadSound").play()
		
		
func fullDeath():
	if currentCheckpoint != null:
		
		self.get_node("NoCorpseDeadSound").play()
		var body = corpse.instance()
		body.set_name("Corpse")
		body.linger = false
		body.noLinger()
		body.position = self.position
		#call_deferred(")
		var wr = weakref(body)
		if wr.get_ref():
			self.get_parent().call_deferred("add_child", body)
		self.position = currentCheckpoint.position
		vel = Vector2()
		totalDeaths += 1
		#print (totalDeaths)
		updateDeaths()
	else:
		print ("ERR; NO SPAWN POINT")

func clearCorpses():
	#for dead in corpses:
	#	dying = true
	#	dead.queue_free()
	var recentBody = corpses.pop_back()
	if recentBody != null:
		recentBody.queue_free()

func coyTime():
	coyTimeRunning = true
	yield(get_tree().create_timer(0.1), "timeout")
	canJump = false
	coyTimeRunning = false	

func _physics_process(delta):

	if is_on_floor():
		
		canJump = true
		
		if resetJump:
			jumping = false
			jumpBoost = maxJumpBoost
			print ("RESET")
			resetJump = false
		
		vel = Vector2(vel.x, 0)
		if maxJumpReached != 10000:
			print (maxJumpReached - currentY)
			maxJumpReached = 10000 
		if vel.x != 0:
			self.get_node("AnimatedSprite").play("Walking")
		else:
			self.get_node("AnimatedSprite").play("Idle")
	else:
		self.get_node("AnimatedSprite").play("Jumping")
		#print (self.global_position.y)
		if self.global_position.y < maxJumpReached:
			maxJumpReached = self.global_position.y
	
	
	if !is_on_floor() && canJump && !coyTimeRunning:
		coyTime()

	
	if jumping:
		vel.y -= jumpBoost * delta
		jumpBoost -= jumpDecay * delta

	vel = Vector2(0, vel.y)

	if Input.is_action_pressed("left"):
		vel.x -= speed
	if Input.is_action_pressed("right"):
		vel.x += speed

	if Input.is_action_pressed("jump") && canJump && !jumping:
		if coyTimeRunning:
			print ("COY JUMP")
		self.get_node("JumpSound").play()
		vel.y = jump
		jumping = true
		currentY = self.global_position.y
		resetJump = true
	
	if Input.is_action_just_released("jump"):
		#print ("not jumping!")
		jumping = false

	if Input.is_action_pressed("suicide"):
		if !dying:
			if Input.is_action_pressed("down"):
				clearCorpses()
				dying = true

			else:
				if !dying:
					death()
					dying = true


	if Input.is_action_just_released("suicide"):
		if dying:
			dying = false

	if Input.is_action_pressed("esc"):
		get_tree().change_scene("res://Scenes/LevelSelect.tscn")

	vel.y += gravity*delta

	move_and_slide(vel, FLOOR_NORMAL)
