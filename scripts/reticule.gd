extends Line2D


var radius = 50
var npoints = 64


# Called when the node enters the scene tree for the first time.
func _ready():
	var data = PackedVector2Array()
	for jj in range(4*npoints):
		var x = self.radius*sin(2*PI*jj/npoints)-self.position.x
		var y = self.radius*cos(2*PI*jj/npoints)-self.position.y
		data.append(Vector2(x, y))
		
	self.points = data
	self.closed = true
	self.width = 4.0
	self.antialiased=true
	self.default_color = Color(0.8, 0.8, 0.8)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
