extends Area2D


export (String) var level
export (int) var curLevel

onready var global = get_node("/root/Global")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SceneTrans_body_entered(body):
	if body.is_in_group("player"):
		#print (global.bestScores)
		#var numLevel = int(level[5]) - 1
		#print ("LEVEL>", numLevel)
		global.bestScores[String(curLevel)] = body.totalDeaths
		get_tree().change_scene("res://Scenes/" + level + ".tscn")
