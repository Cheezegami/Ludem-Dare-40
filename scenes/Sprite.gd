extends Sprite
onready var world = get_parent().get_parent().get_parent()
var speed = 16
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	position.y += delta * speed * world.powerlevel
	if(position.y > 640):
		position.y -= 640
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
