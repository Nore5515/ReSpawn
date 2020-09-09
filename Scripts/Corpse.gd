extends KinematicBody2D

export (bool) var linger = true
var wr = weakref(self)

func _ready():
	if !linger: #&& wr.get_ref():
		self.get_node("characterdead").visible = false
		#if self.has_node("characterdead"):
			#self.get_node("pixil-frame-0").visible = false
			#call_deferred("set", get_node("characterdead").visible, false)
		if self.has_node("CollisionShape2D"):
			call_deferred("set", get_node("CollisionShape2D").disabled, true)
			#self.get_node("CollisionShape2D").disabled = true
	
	if !wr.get_ref():
		print ("DEAD DEAD DEAD")

func noLinger():
	if !linger && wr.get_ref():
		if self.has_node("characterdead"):
			#self.get_node("pixil-frame-0").visible = false
			call_deferred("set", get_node("characterdead").visible, false)
		if self.has_node("CollisionShape2D"):
			call_deferred("set", get_node("CollisionShape2D").disabled, true)
			#self.get_node("CollisionShape2D").disabled = true

func _on_Timer_timeout():
	self.get_node("CPUParticles2D").emitting = false
	if !linger:
		queue_free()
