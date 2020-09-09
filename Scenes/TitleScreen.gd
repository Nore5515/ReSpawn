extends Node2D


var resolution = Vector2(160, 144)
var screenScale = 5
export (bool) var first = false

onready var global = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	global.onTitle()
	
	if first && !global.initGrow:
		global.initGrow = true
		#print("gO", get_viewport().size)
		get_viewport().set_size(resolution * screenScale)
		OS.set_window_size(get_viewport().size)

func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Level1.tscn")

func _on_LevelSelect_pressed():
	get_tree().change_scene("res://Scenes/LevelSelect.tscn")


func _on_Quit_pressed():
	get_tree().quit()
