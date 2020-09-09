extends Node2D


var x = 1
var y = 1
var maxX = 6
var maxY = 3
var xBuff = 20
var yBuff = 20

var tap = true
var level = 1

onready var global = get_node("/root/Global")

var parLevels = {
	"1": 0,
	"2": 3,
	"3": 1,
	"4": 5,
	"5": 1,
	"6": 3,
	"7": 2,
	"8": 1,
	"9": 5,
	"10": 20,
	"11": 7,
	"12": 3,
	"13": 7,
	
	#################
	
	"14": 0,
	"15": 0,
	"16": 0,
	"17": 0,
	"18": 0,
}

onready var levelNums = get_tree().get_nodes_in_group("levelNum")

var allPar = true

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var babbies
	for someLevel in range(13):
		if global.bestScores[String(someLevel+1)] <= parLevels[String(someLevel+1)]:
			#print ("GOLDED")
			pass
		else:
			babbies = self.get_parent().get_node(String(someLevel+1)).get_children()
			for b in babbies:
				if "blu" in b.name || "num" in b.name:
					#print ("BLUE")
					b.visible = false
					allPar = false
	
	if allPar:
		global.playWinSound()
	
	#for num in levelNums:
		


func _physics_process(delta):

	position = Vector2(x*xBuff, y*yBuff)

	if x < 1:
		x = 1
	if y < 1:
		y = 1
	if x > maxX:
		x = maxX
	if y > maxY:
		y = maxY

	level = ((y-1) * 6) + x
	self.get_parent().get_node("Par").text = "Par: " + String(parLevels[String(level)]) + "   Best: " + String(global.bestScores[String(level)])

	if !tap:
		if Input.is_action_pressed("left"):
			self.get_node("AudioStreamPlayer").play()
			x -= 1
			if x < 1:
				x = 1
			tap = true
		if Input.is_action_pressed("right"):
			self.get_node("AudioStreamPlayer").play()
			x += 1
			if x > maxX:
				x = maxX
			tap = true
	
		if Input.is_action_pressed("down"):
			self.get_node("AudioStreamPlayer").play()
			y += 1
			if y > maxY:
				y = maxY
			tap = true
		if Input.is_action_pressed("up"):
			self.get_node("AudioStreamPlayer").play()
			y -= 1
			if y < 1:
				y = 1
			tap = true

		if Input.is_action_pressed("select"):
			global.offTitle()
			get_tree().change_scene("res://Scenes/Level" + String(level) + ".tscn")
			tap = true

	if Input.is_action_just_released("left") || Input.is_action_just_released("right") || Input.is_action_just_released("up") || Input.is_action_just_released("down"):
		tap = false
