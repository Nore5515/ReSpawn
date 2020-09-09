extends Node2D


var tap = false
var y = 0
var maxY = 1

var ySpacing = 40

var basePosition

onready var global = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	basePosition = self.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	self.position.y = basePosition.y + (y * ySpacing)
	
	if !tap:
		
			if Input.is_action_pressed("down"):
				print ("DOWN")
				y += 1
				if y > maxY:
					y = maxY
				tap = true
				self.get_node("SelectNoise").play()
				
			if Input.is_action_pressed("up"):
				print ("UP")
				y -= 1
				if y < 0:
					y = 0
				tap = true
				self.get_node("SelectNoise").play()
	
			if Input.is_action_pressed("select"):
				if y == 0: 
					get_tree().change_scene("res://Scenes/Level1.tscn")
					global.offTitle()
				elif y == 1:
					get_tree().change_scene("res://Scenes/LevelSelect.tscn")
				else:
					get_tree().quit()
				tap = true
	
	if Input.is_action_just_released("up") || Input.is_action_just_released("down"):
		tap = false
