extends Node2D
const enemyCDBase = 2
var enemycd = 2
var enemyCooldown = 0
var enemyCount = 0
var powerlevel = 1

var enemyPrefab = preload("res://scenes/Enemy.tscn")
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	enemycd = enemyCDBase / powerlevel
	if(enemyCooldown < 0):
		var localNode = enemyPrefab.instance()
		localNode.set_name("Enemy"+str(enemyCount))
		add_child(localNode)
		#use below variable for individual node access.
		var instance_node = get_node("Enemy"+str(enemyCount))
		instance_node.id = enemyCount
		#instance_node.add_collision_exception_with(self)
		instance_node.position = Vector2(rand_range(24,1000),-32)
		
		#instance_node.projVelocity += Vector2(0, -1) + (velocity * 0.3)
		enemyCount += 1
		enemyCooldown = enemycd;
	else:
		enemyCooldown -= delta
	get_node("Label").text = "Power Level = "+str(powerlevel)
