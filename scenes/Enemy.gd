extends KinematicBody2D
const coreSpeed = 30
var lifetime = 30
var speed = 30
var id = 0
var velocity = Vector2(0,0)
var pickPrefab = preload("res://scenes/Pick-up.tscn")
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
	move_and_collide(velocity)
	pass

func _die():
	var localNode = pickPrefab.instance()
	localNode.set_name("Pick-Up"+str(id))
	get_parent().add_child(localNode)
	#use below variable for individual node access.
	var instance_node = get_parent().get_node("Pick-Up"+str(id))
	#instance_node.add_collision_exception_with(self)
	instance_node.global_position = self.global_position
	#instance_node.projVelocity += Vector2(0, -1) + (velocity * 0.3)
	queue_free()