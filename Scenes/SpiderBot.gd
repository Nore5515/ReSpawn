extends KinematicBody2D


# STEP 1
# Move left until...
# Bottom Collider leaves floor
# OR
# Side Collider (thin!) hits player/corpse/wall

# STEP 2
# If the hit object was the player, kill them.
# Flip direction.

# STEP 3
# Repeat!


var speed = 30
var rightDirection = true


func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if rightDirection:
		position += transform.x * speed * delta
	else:
		position += transform.x * -speed * delta
		

func _on_LeftBumper_body_entered(body):
	print ("BODY>", body)
	if body.is_in_group("corpse") || body.is_in_group("tilemap"):
		rightDirection = true
func _on_RightBumper_body_entered(body):
	print ("BODY>", body)
	if body.is_in_group("corpse") || body.is_in_group("tilemap"):
		rightDirection = false


func _on_LeftFloorRail_body_exited(body):
	if body.is_in_group("tilemap"):
		print ("bye floor")
		rightDirection = true
func _on_RightFloorRail_body_exited(body):
	if body.is_in_group("tilemap"):
		rightDirection = false


func _on_Killbox_body_entered(body):
	if body.is_in_group("player"):
		body.fullDeath()
