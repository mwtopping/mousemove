extends Polygon2D

var locPos = Vector2(0.0, 0.0)
var dist = remap(randf(), 0, 1, 0.5, 1)
# Called when the node enters the scene tree for the first time.
func _ready():
	self.scale *= (1-dist)+0.2
	self.locPos.x = 5000*(randf()-0.5)
	self.locPos.y = 5000*(randf()-0.5)
	self.position = locPos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#self.position.x += randf()-0.5
	#self.position.y += randf()-0.5
	var parent = get_parent()
	var player = parent.get_node("Icon2")
	var camera = player.get_node("Camera")
	self.position = self.locPos + dist*camera.get_screen_center_position()
	#self.position = self.locPos - 1.5*camera.global_position+player.global_position
	#print(camera.position)

