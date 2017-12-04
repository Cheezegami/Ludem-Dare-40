extends Node2D
const SPEED = 600
var velocity = Vector2(0,0)
var attackCount = 0
var attackPrefab = preload("res://scenes/FriendlyProjectile.tscn")
const ATTACKCDBASE = 1
var ATTACKCD = 1
var attackCD = ATTACKCD
onready var world = get_parent()
var upgrade_value = 0.04

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_meta("type", "player")
	
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	self.scale = Vector2(1+world.powerlevel,1+world.powerlevel)
	ATTACKCD = ATTACKCDBASE / world.powerlevel
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	#Movement
	if (Input.is_action_pressed("ui_left")):
		velocity.x = -1
	
	elif (Input.is_action_pressed("ui_right")):
		velocity.x = 1
	
	else:
		velocity.x = 0

	if (Input.is_action_pressed("ui_up")):
		velocity.y = -1
	
	elif (Input.is_action_pressed("ui_down")):
		velocity.y = 1
	
	else:
		velocity.y = 0

	var motion = (velocity.normalized()) * delta * SPEED

	if(Input.is_action_pressed("ui_select") && attackCD <= 0):
		var localNode = attackPrefab.instance()
		localNode.set_name("PlayerProjectile"+str(attackCount))
		get_parent().add_child(localNode)
		
		
		#use below variable for individual node access.
		var instance_node = get_parent().get_node("PlayerProjectile"+str(attackCount))
		instance_node.add_collision_exception_with(self)
		instance_node.position = self.position + Vector2(0,-32)
		instance_node.rotate(rand_range(PI/2-(world.powerlevel/25),PI/2+(world.powerlevel/25)))
		#instance_node.rotate(rand_range(-world.powerlevel*2,world.powerlevel*2))
		#instance_node.projVelocity += Vector2(0, -1) + (velocity * 0.3)
		attackCount += 1
		attackCD = ATTACKCD
	else:
		attackCD -= delta
	var n = move_and_collide(motion)
	if (n != null):
		var colliderObject = n.collider
		if(colliderObject.has_meta("type")):
			if(colliderObject.get_meta("type") == "pickup"):
				colliderObject.upgrade()
				#world.get_node("Sound").play("hit", true)
				colliderObject._die()
				#pierce -= 1
				#world.freezeFrames = 0.1
				#world.get_node("Camera2D").shake(0.5, 10, 1.5)

	
