extends Area2D


var current = false
onready var allPoints = get_tree().get_nodes_in_group("checkpoints")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_node("CHECKPOINT").visible = false
	self.get_node("CHECKPOINTDOWN").visible = true


func setAsMain():
	
	if !current:
		self.get_node("AudioStreamPlayer").play()
		
	for point in allPoints:
		point.current = false
		point.get_node("CHECKPOINT").visible = false
		point.get_node("CHECKPOINTDOWN").visible = true
	current = true
	self.get_node("CHECKPOINT").visible = true
	self.get_node("CHECKPOINTDOWN").visible = false
	#print ("ENABLED")
	

func _on_Checkpoint_body_entered(body):
	if body.is_in_group("player"):
		body.inCheckpoint = true
		setAsMain()
		body.updateCheckpoint()


func _on_Checkpoint_body_exited(body):
	if body.is_in_group("player"):
		body.inCheckpoint = false
		
