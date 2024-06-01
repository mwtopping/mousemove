extends Polygon2D

var radius = randf()*30+10
var npoints = 64
var semi_major_axis = 100+randf()*1000
var phi = randf()*2*PI
# Called when the node enters the scene tree for the first time.
func _ready():
	var data = PackedVector2Array()
	for ii in range(npoints):
		var x = self.radius * sin(2*PI*float(ii)/npoints)
		var y = self.radius * cos(2*PI*float(ii)/npoints)
		data.append(Vector2(x, y))
	self.polygon = data
	self.color = Color(.5, .3, .2)
	
	self.position = Vector2(self.semi_major_axis*sin(2*PI*self.phi), self.semi_major_axis*cos(2*PI*self.phi))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		self.phi += 0.1*delta/sqrt(self.semi_major_axis)
		self.position = Vector2(self.semi_major_axis*sin(2*PI*self.phi), 
								self.semi_major_axis*cos(2*PI*self.phi))
