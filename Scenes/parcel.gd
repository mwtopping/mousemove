extends Polygon2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.x += randf()-0.5
	self.position.y += randf()-0.5
	pass
