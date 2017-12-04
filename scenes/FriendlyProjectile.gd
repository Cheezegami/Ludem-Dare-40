extends Node2D
var speed = 200
var velocity = Vector2(0,0)
onready var world = get_parent()
var timeLeft = 12
var alive = true
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	timeLeft -= delta
	
	if(alive):
		self.scale  = Vector2(world.powerlevel / 2,world.powerlevel / 2)
		velocity.y = -speed * delta
		# Called every frame. Delta is time since last frame.
		# Update game logic here.
		var n = move_and_collide(velocity)
		if (n != null):
			var colliderObject = n.collider
			if(colliderObject.has_meta("type")):
				if(colliderObject.get_meta("type") == "enemy"):
					#world.get_node("Sound").play("hit", true)
					colliderObject._die()
					_die()
					#pierce -= 1
					#world.freezeFrames = 0.1
					#world.get_node("Camera2D").shake(0.5, 10, 1.5)
	else:
		var n = move_and_collide(Vector2(0,0))
		if (n != null):
			var colliderObject = n.collider
			if(colliderObject.has_meta("type")):
				if(colliderObject.get_meta("type") == "enemy"):
					#world.get_node("Sound").play("hit", true)
					colliderObject._die()
		get_node("CollisionShape2D").apply_scale(Vector2(1+(delta*timeLeft*5),1+(delta*timeLeft*5)))
	if(timeLeft < 0):
		queue_free()
	pass

func _die():
	alive = false;
	timeLeft = get_node("Explosion").lifetime-1
	get_node("Particles2D").hide()
	get_node("Explosion").show()
	get_node("Explosion").restart()
	
	