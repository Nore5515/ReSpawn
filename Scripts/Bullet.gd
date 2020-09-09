extends Area2D


var speed = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	position += transform.x * speed


func _on_Bullet_body_entered(body):
	if body.is_in_group("player"):
		body.fullDeath()
	if body.is_in_group("corpse") || body.is_in_group("map") || body.is_in_group("tilemap"):
		self.queue_free()
