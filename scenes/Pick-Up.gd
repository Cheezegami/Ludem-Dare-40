extends KinematicBody2D
const corespeed = 60
var speed = corespeed
var velocity = Vector2(0,0)
var lifetime = 30;
onready var world = get_parent()
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_meta("type", "pickup")
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	speed = (corespeed * 0.5) + (corespeed * world.powerlevel * 0.5)
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	lifetime -= delta
	if(lifetime < 0):
		queue_free()
	velocity.y = speed * delta
	var n = move_and_collide(velocity)
	if (n != null):
		var colliderObject = n.collider
		if(colliderObject.has_meta("type")):
			if(colliderObject.get_meta("type") == "player"):
				colliderObject.upgrade()
				#world.get_node("Sound").play("hit", true)
				_die()
				#pierce -= 1
				#world.freezeFrames = 0.1
				#world.get_node("Camera2D").shake(0.5, 10, 1.5)
	pass

func _die():
	queue_free()