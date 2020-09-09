extends KinematicBody2D

var bullet = load("res://Scenes/Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_node("Timer").start()


func _on_Timer_timeout():
	var boolet = bullet.instance()
	boolet.set_name("Boolet")
	boolet.position = self.position
	boolet.rotation = self.rotation
	self.get_parent().add_child(boolet)
	
	self.get_node("AudioStreamPlayer").play()
