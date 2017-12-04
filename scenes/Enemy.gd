extends KinematicBody2D
const coreSpeed = 30
var lifetime = 30
var speed = 30
var id = 0
var velocity = Vector2(0,0)
var pickPrefab = preload("res://scenes/Pick-up.tscn")
var healthPrefab = preload("res://scenes/Health-up.tscn")
onready var world = get_parent()
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_meta("type", "enemy")
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	lifetime -= delta
	if(lifetime < 0):
		queue_free()
	speed = coreSpeed * world.powerlevel
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	velocity.y = speed * delta 
	var n = move_and_collide(velocity)
	if (n != null):
		var colliderObject = n.collider
		if(colliderObject.has_meta("type")):
			if(colliderObject.get_meta("type") == "deathwall" || colliderObject.get_meta("type") == "player"):
				#world.get_node("Sound").play("hit", true)
				world.health -= 1
				queue_free()
				#pierce -= 1
				#world.freezeFrames = 0.1
				#world.get_node("Camera2D").shake(0.5, 10, 1.5)
	pass

func _die():
	var amount = rand_range(1,4)
	for i in range(0, amount):
		var rand = rand_range(0,10)
		var localNode
		if(rand > 1):
			localNode = pickPrefab.instance()
		else:
			localNode = healthPrefab.instance()
		localNode.set_name("Pick-Up"+str(id)+"i"+(str(i)))
		get_parent().add_child(localNode)
		#use below variable for individual node access.
		var instance_node = get_parent().get_node("Pick-Up"+str(id)+"i"+(str(i)))
		#instance_node.add_collision_exception_with(self)
		instance_node.global_position = self.global_position + Vector2(rand_range(-1,1),rand_range(-1,1))
		#instance_node.projVelocity += Vector2(0, -1) + (velocity * 0.3)
	queue_free()